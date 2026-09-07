# dotfiles

Configuration for my machines, kept in a bare git repository whose work tree is
`$HOME`. Files are tracked in place, so there are no symlinks to manage.

## Layout

The distribution owns `~/.bashrc` and the login file (`~/.bash_profile`,
`~/.bash_login` or `~/.profile`, depending on the distribution). Those are never
tracked: replacing them means fighting whatever each distribution ships, and
they are the natural home for settings that apply to one machine only.

Instead, each gets one appended hook line that sources a tracked fragment:

| Untracked, machine-owned | Hook sources |
| ------------------------ | ------------ |
| `~/.bashrc`              | `~/.config/shell/rc` — interactive settings, aliases, tool init |
| login file              | `~/.config/shell/profile` — exported environment |

Machine-specific settings go directly into the untracked file, below the hook
line, where they can override the shared fragment. Nothing outside
`~/.config/shell` needs to know which distribution this is.

## New machine

The `config` alias lives in `~/.config/shell/rc`, which does not exist until the
repository is checked out, so the first three commands spell out the full git
invocation.

```sh
git clone --bare git@github.com:N3utra1/.dotfiles.git "$HOME/.dotfiles"
git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" checkout
git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" config status.showUntrackedFiles no
bash "$HOME/.bin/dotfiles-bootstrap.sh"
exec bash -l
```

`checkout` refuses to overwrite existing files. If it reports conflicts, move the
named files aside and run it again.

`dotfiles-bootstrap.sh` installs the hook lines and is safe to re-run; it skips
any hook already present.

## Everyday use

```sh
config status
config add ~/.config/shell/rc
config commit -m "..."
config push
```

`status.showUntrackedFiles no` is required. Without it `config status` lists
every file in `$HOME`.

## Submodules

`~/.config/nvim` is a submodule pointing at `N3utra1/nvim`. Commit and push
inside that directory first; the parent repository only records which commit to
check out.

```sh
git -C ~/.config/nvim add -A && git -C ~/.config/nvim commit && git -C ~/.config/nvim push
config add ~/.config/nvim
```

Clone with `--recurse-submodules`, or run `config submodule update --init` after
checkout.

## What is deliberately not here

Credentials, private keys, VPN profiles and shell history are listed in
`.gitignore`. Anything that exports an access key stays on the machine that
needs it.
