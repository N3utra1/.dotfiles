#!/bin/bash
#set -xe

# clone the repo into the .dotfiles directory
#       exit 1 if error when cloning directory 
#       exit 2 if directory (~/.dotfiles) already exists
if [ ! -d ~/.dotfiles ]; then
    git clone --bare git@github.com:N3utra1/.dotfiles.git ~/.dotfiles || echo "git clone failed" && exit 1
else
    echo "~/.dotfiles already exists!"
    exit 2
fi

# this will not overwrite your existing dotfiles!
CONFIG="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
$CONFIG checkout
source ~/.bashrc
