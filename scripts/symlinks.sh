#!/bin/bash

# Script creates symlinks from ~ to ~/dotfiles

files='bash_aliases bashrc gitconfig inputrc'

# Back-up existing files:
echo 'Backing up current dotfiles to ~/old_dotfiles'
mkdir ~/old_dotfiles
for file in $files; do
    mv ~/.$file ~/old_dotfiles/.$file
done

# Create symlinks to dotfiles repo
echo 'Creating symlinks for dotfiles'
for file in $files
do
	ln -s ~/dotfiles/$file ~/.$file
done

echo 'Finished with dotfile symlinks!'
