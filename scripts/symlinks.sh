#!/bin/bash

# Script creates symlinks from ~ to ~/dotfiles

files='bash_aliases bash_profile bashrc gitconfig inputrc tmux.conf'

# Back-up existing files:
echo 'Backing up current dotfiles to ~/old_dotfiles'
mkdir ~/old_dotfiles
for file in $files; do
    if [ -f ~/.$file ]; then
        mv ~/.$file ~/old_dotfiles/.$file
    fi
done

# Create symlinks to dotfiles repo
echo 'Creating symlinks for dotfiles'
for file in $files
do
	ln -s ~/dotfiles/$file ~/.$file
done

echo 'Finished with dotfile symlinks!'
