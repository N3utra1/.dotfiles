#!/usr/bin/env bash
#
# Wire a freshly provisioned machine into the tracked shell configuration.
#
# The distribution owns ~/.bashrc and the login file, so they are never tracked
# in this repository. Instead each one gets a single hook line appended that
# sources the shared fragment under ~/.config/shell. Machine-specific settings
# go in the tracked ~/.config/shell/<hostname>.rc, which the shared fragment
# sources; only secrets go into the untracked file.
#
# Safe to re-run: every edit is guarded by a check for the line it adds.

set -euo pipefail

RC_HOOK='[ -r ~/.config/shell/rc ] && . ~/.config/shell/rc'
PROFILE_HOOK='[ -r ~/.config/shell/profile ] && . ~/.config/shell/profile'

# Interactive shells read ~/.bashrc, and nothing else can stand in for it.
touch "$HOME/.bashrc"
if ! grep -qxF "$RC_HOOK" "$HOME/.bashrc"; then
  printf '\n# shared shell configuration (tracked in ~/.dotfiles)\n%s\n' \
    "$RC_HOOK" >>"$HOME/.bashrc"
  echo "hooked ~/.bashrc"
fi

# A bash login shell reads the FIRST of these that exists and ignores the rest,
# so hook whichever one is actually in effect. Debian and Ubuntu ship only
# ~/.profile; Fedora, RHEL and Arch ship ~/.bash_profile, which would shadow it.
profile=""
for candidate in "$HOME/.bash_profile" "$HOME/.bash_login" "$HOME/.profile"; do
  if [ -f "$candidate" ]; then
    profile=$candidate
    break
  fi
done
profile=${profile:-$HOME/.profile}

touch "$profile"
if ! grep -qxF "$PROFILE_HOOK" "$profile"; then
  printf '\n# shared shell environment (tracked in ~/.dotfiles)\n%s\n' \
    "$PROFILE_HOOK" >>"$profile"
  echo "hooked $profile"
fi

# i3 loads ~/.config/i3/config, which is generated and not tracked, so build it
# once here; after that the i3 config rebuilds it on every start.
if [ -r "$HOME/.config/i3/config.base" ]; then
  sh "$HOME/.bin/i3-build-config.sh"
  echo "built ~/.config/i3/config"
fi

echo "bootstrap complete; open a new shell or run: source ~/.bashrc"
