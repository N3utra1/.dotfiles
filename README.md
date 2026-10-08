# dotfiles

Configuration for my machines, kept in a bare git repository whose work tree is
`$HOME`. Files are tracked in place, so there are no symlinks to manage.

## Layout

The distribution owns `~/.bashrc` and the login file (`~/.bash_profile`,
`~/.bash_login` or `~/.profile`, depending on the distribution). Those are never
tracked: replacing them means fighting whatever each distribution ships.

Instead, each gets one appended hook line that sources a tracked fragment:

| Untracked, machine-owned | Hook sources |
| ------------------------ | ------------ |
| `~/.bashrc`              | `~/.config/shell/rc` — interactive settings, aliases, tool init |
| login file              | `~/.config/shell/profile` — exported environment |

Nothing outside `~/.config/shell` needs to know which distribution this is.

## Per-machine settings

Settings for one machine are tracked too, in files named after `hostname -s`,
so every machine's configuration can be read and edited from any checkout. Only
the file matching the current host is loaded, after the shared one, so it can
override it. A machine with no file of its own gets the shared configuration.

| Shared                     | Per machine                          | Loaded by |
| -------------------------- | ------------------------------------ | --------- |
| `~/.config/shell/rc`       | `~/.config/shell/<hostname>.rc`      | the end of `~/.config/shell/rc` |
| `~/.config/X11/Xresources` | `~/.config/X11/<hostname>.Xresources` | `~/.bin/load-xresources.sh`, run by the i3 config |
| `~/.config/i3/config.base` | `~/.config/i3/<hostname>.conf`        | `~/.bin/i3-build-config.sh`, which writes `~/.config/i3/config` |

i3 has no way to read a second file before version 4.20, so its two files are
joined into `~/.config/i3/config`, which is generated and ignored. Edit
`config.base` or the host file and press `$mod+Shift+r`; never edit the
generated file. A variable set in the host file (`set $term urxvt`) replaces the
shared definition.

Wallpapers are tracked in `~/.config/i3/wallpapers`, named for what they show,
not for a machine. `config.base` sets the default; a machine that wants a
different one sets it with its own `feh` line in its host file.

`~/.Xresources` is not used. To set up a new machine, create its files and
`config add` them; untracked files are hidden from `config status`, so a new
host file is easy to forget.

These files are pushed with everything else, so secrets still go in the
untracked `~/.bashrc` or in ignored scripts under `~/.bin`.

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
