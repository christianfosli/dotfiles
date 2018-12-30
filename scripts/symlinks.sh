#!/bin/bash

# Script creates symlinks from ~ to ~/dotfiles

public_dotfiles='bash_aliases bash_profile bashrc inputrc tmux.conf'
private_dotfiles='gitconfig'

# Back-up existing files
printf 'Backing up current dotfiles to ~/old_dotfiles\n'
mkdir ~/old_dotfiles

for file in $public_dotfiles; do
    if [ -f ~/.$file ]; then
        mv ~/.$file ~/old_dotfiles/.$file
    fi
done

for file in $private_dotfiles; do
    if [ -f ~/.$file ]; then
        mv ~/.$file ~/old_dotfiles/.$file
    fi
done

# Create symlinks to dotfiles repo
printf 'Creating symlinks for public dotfiles\n'

for file in $public_dotfiles
do
    ln -s ~/dotfiles/$file ~/.$file
done

printf 'Creating symlinks from private dotfiles\n'

[[ -d ~/dotfiles_private ]] || git clone https://github.com/christianfosli/dotfiles_private

for file in $private_dotfiles
do
    ln -s ~/dotfiles_private/$file ~/.$file
done
