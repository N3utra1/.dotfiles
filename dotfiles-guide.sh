#!/bin/bash
set -xe

# clone the repo into the .dotfiles directory
# this will not overwrite you existing dotfiles!
if [ ! -d ~/.dotfiles ] 
    then
    git clone --bare git@github.com:N3utra1/.dotfiles.git ~/.dotfiles
fi

if grep -q 'alias config=' ~/.bashrc; then
    echo "Alias 'config' exists in .bashrc"
else
    echo "Alias 'reload' does not exist in .bashrc"
    echo "Alias config='/usr/bin/git --git-dir=/home/zeta/.dotfiles/ --work-tree=/home/zeta'" >> ~./bashrc
fi

source ~/.bashrc
echo "Type: "
echo "$: config checkout -b <suitable-name> "
echo "Now go use the config alias to add your files."
echo "..."

echo "Then, commit and push"
echo "$: config commit '<suitable-message>' "

