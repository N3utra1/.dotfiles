Setup steps:
git init --bare $HOME/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME' (add this alias to .bashrc)
bash
config config --local status.showUntrackedFiles no

Basic usage example:

config add /path/to/file
config commit -m "A short message"
config push

TO INSTALL:
curl https://raw.githubusercontent.com/N3utra1/.dotfiles/refs/heads/init/dotfiles-guide.sh | /bin/bash
