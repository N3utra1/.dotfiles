#!/usr/bin/env bash
#
# Pick one of the chaaps project directories listed below from a centred,
# curses-style menu and open it in nvim. The box is re-centred whenever the
# terminal is resized.
#
# Keys: up/down or k/j move, enter opens, q or esc quits.

# This script calls exit and exec, which act on the calling shell when the file
# is sourced: quitting the menu, or quitting nvim afterwards, would close the
# terminal or tmux pane. If sourced, run a separate process instead.
if [[ ${BASH_SOURCE[0]} != "$0" ]]; then
  bash "${BASH_SOURCE[0]}" "$@"
  return
fi

# Add or remove entries here; the menu is built from this list. A directory is
# opened in nvim with the working directory set to it.
RC_FILES=(
  ~/Projects/chaaps/chaaps-v1/
  ~/Projects/chaaps/chaaps-v1/chaaps-v1-installer
  ~/Projects/chaaps/chaaps-v2/
  ~/Projects/chaaps/chaaps-v2/chaaps-v2-installer
  ~/Projects/chaaps/msc-cloud/
)

set -u

if [[ ! -t 0 || ! -t 1 ]]; then
  echo "chaaps.sh: needs an interactive terminal" >&2
  exit 1
fi

if ! command -v nvim >/dev/null; then
  echo "chaaps.sh: nvim not found in PATH" >&2
  exit 1
fi

count=${#RC_FILES[@]}
if ((count == 0)); then
  echo "chaaps.sh: RC_FILES is empty" >&2
  exit 1
fi

# Switch to the alternate screen and hide the cursor; undo both on any exit.
restore_terminal() { printf '\e[?25h\e[?1049l'; }
trap restore_terminal EXIT
printf '\e[?1049h\e[?25l'

# Set on terminal resize (and after every key) so the main loop redraws.
redraw=1
trap 'redraw=1' WINCH

tilde='~'
title='Select a chaaps project'
hint='up/down j/k: move   enter: open   q: quit'

# Menu labels, and the box interior width: widest of label (plus room for the
# highlight bar), title and hint, with one column of padding on each side.
labels=()
inner=0
for path in "${RC_FILES[@]}"; do
  label=${path/#$HOME/$tilde}
  if [[ -d $path ]]; then
    label=${label%/}/
  elif [[ ! -e $path ]]; then
    label+=' (missing)'
  fi
  labels+=("$label")
  ((${#label} + 2 > inner)) && inner=$((${#label} + 2))
done
((${#title} > inner)) && inner=${#title}
((${#hint} > inner)) && inner=${#hint}
inner=$((inner + 2))
# Top edge, title, rule, list, rule, hint, bottom edge.
height=$((count + 6))

# Box position (screen row/column of the top-left corner); set by draw.
top=1
left=1

# Print $1 repeated $2 times.
rep() {
  local pad
  printf -v pad '%*s' "$2" ''
  printf '%s' "${pad// /$1}"
}

# Print $1 centred within the box interior.
center() {
  local l=$(((inner - ${#1}) / 2))
  printf '%*s%s%*s' "$l" '' "$1" $((inner - ${#1} - l)) ''
}

# Print a horizontal edge/rule on box row $1 with end pieces $2 and $3.
# Drawn in the ACS line-drawing set (\e(0): l k m j corners, t u tees, q rule),
# which works in any locale.
rule() {
  printf '\e[%d;%dH\e(0%s%s%s\e(B' $((top + $1)) "$left" "$2" "$(rep q "$inner")" "$3"
}

# Print $2 centred on box row $1 between vertical borders, wrapped in style $3.
line() {
  printf '\e[%d;%dH\e(0x\e(B%s%s\e[0m\e(0x\e(B' \
    $((top + $1)) "$left" "${3-}" "$(center "$2")"
}

draw() {
  local size rows cols i
  size=$(stty size)
  rows=${size% *}
  cols=${size#* }
  top=$(((rows - height) / 2 + 1))
  left=$(((cols - inner - 2) / 2 + 1))
  ((top < 1)) && top=1
  ((left < 1)) && left=1

  printf '\e[H\e[2J'
  rule 0 l k
  line 1 "$title" $'\e[1m'
  rule 2 t u
  for i in "${!labels[@]}"; do
    if ((i == sel)); then
      line $((3 + i)) "${labels[i]}" $'\e[7m'
    else
      line $((3 + i)) "${labels[i]}"
    fi
  done
  rule $((3 + count)) t u
  line $((4 + count)) "$hint" $'\e[2m'
  rule $((5 + count)) m j
}

sel=0
choice=
while true; do
  if ((redraw)); then
    draw
    redraw=0
  fi
  # Short timeout (status > 128) so a pending resize is noticed promptly:
  # bash does not abort a blocking read when the WINCH trap fires.
  IFS= read -rsn1 -t 0.2 key || {
    (($? > 128)) && continue
    break
  }
  redraw=1

  # Arrow keys arrive as ESC [ A/B (or ESC O A/B); a lone ESC means quit.
  if [[ $key == $'\e' ]]; then
    rest=
    IFS= read -rsn2 -t 0.05 rest || true
    case $rest in
    '[A' | 'OA') key=k ;;
    '[B' | 'OB') key=j ;;
    '') key=q ;;
    *) key=_ ;;
    esac
  fi

  case $key in
  k) sel=$(((sel - 1 + count) % count)) ;;
  j) sel=$(((sel + 1) % count)) ;;
  q) break ;;
  '')
    choice=${RC_FILES[sel]}
    break
    ;; # enter reads as an empty key
  esac
done

[[ -n $choice ]] || exit 0

# Leave the alternate screen first: exec replaces this shell, skipping the trap.
restore_terminal
if [[ -d $choice ]]; then
  # Start nvim inside the directory so its file pickers and project root are
  # scoped to it rather than to wherever the menu was launched from.
  cd "$choice" || exit 1
  exec nvim .
fi
exec nvim "$choice"
