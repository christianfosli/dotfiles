#!/bin/bash

# Script creates symlinks from ~ to ~/dotfiles
# This script works both on Unix and on Git-Bash for windows
# As of writing this script the `ln -s` command in git-bash
# does not create a link, so we need to have powershell do so

public_dotfiles='bash_aliases bash_profile bashrc inputrc tmux.conf'
private_dotfiles='gitconfig'
windows() { [[ -n $WINDIR ]]; }

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
    if windows; then
        powershell New-Item -ItemType SymbolicLink\
            -Path \$Home/.$file\
            -Target \$Home/dotfiles/$file
    else
        ln -s ~/dotfiles/$file ~/.$file
    fi
done

printf 'Creating symlinks from private dotfiles\n'

[[ -d ~/dotfiles_private ]] || git clone https://github.com/christianfosli/dotfiles_private

for file in $private_dotfiles
do
    if windows; then
        powershell New-Item -ItemType SymbolicLink\
            -Path \$Home/.$file\
            -Target \$Home/dotfiles_private/$file
    else
        ln -s ~/dotfiles_private/$file ~/.$file
    fi
done
