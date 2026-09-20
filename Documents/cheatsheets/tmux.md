# tmux Main Keybinds

Prefix = `Ctrl+Space` (press it, release, then press the next key).
**No prefix** means the key works on its own.

## Sessions

| Action | Keys / Command |
|---|---|
| New named session | `tmux new -s name` (shell) |
| Detach | `prefix d` |
| Attach | `tmux attach -t name` (shell) |
| List sessions | `tmux ls` (shell) or `prefix s` |
| Switch session | `prefix s`, pick, `Enter` |
| Previous / next session | `prefix (` / `prefix )` |
| Kill session | `prefix :` then `kill-session -t name` |
| Kill all others | `prefix :` then `kill-session -a` |
| Kill everything | `prefix :` then `kill-server` |

## Windows (tabs)

| Action | Keys |
|---|---|
| New window | `prefix c` |
| Go to window N | `prefix 1` ... `prefix 9` |
| Next / previous | `prefix n` / `prefix p` |
| Next / previous (**no prefix**) | `Alt+Shift+L` / `Alt+Shift+H` |
| Window list | `prefix w` |
| Rename window | `prefix ,` |
| Close window | `prefix &` |

## Panes (splits)

| Action | Keys |
|---|---|
| Split left / right | `prefix %` |
| Split top / bottom | `prefix "` |
| Move between panes (**no prefix**) | `Ctrl+h/j/k/l` |
| Zoom pane (toggle) | `prefix z` |
| Swap panes | `prefix {` / `prefix }` |
| Pane to window | `prefix !` |
| Close pane | `prefix x` |

## Copy mode (vi keys)

| Action | Keys |
|---|---|
| Enter copy mode | `prefix [` |
| Start selection | `v` |
| Rectangle select | `Ctrl+v` |
| Copy and exit | `y` |

## Config and plugins

| Action | Keys / Command |
|---|---|
| Install plugins (TPM) | `prefix Shift+I` |
| Reload config | `tmux source ~/.tmux.conf` |
| Reload with `prefix r` | add `bind r source-file ~/.tmux.conf \; display "Reloaded"` to config |
| Command prompt | `prefix :` |
