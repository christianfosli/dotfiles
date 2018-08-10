#!/bin/bash

# Script should be run on new installs

# Make symlinks to dotfiles
chmod u+x ~/dotfiles/scripts/symlinks.sh
~/dotfiles/scripts/symlinks.sh

# Clone vim dotfiles from github
echo 'Cloning vim dotfiles from github'
git clone https://github.com/christianfosli/vimConfig.git ~/.vim

# Install applicable pkgs
chmod u+x ~/dotfiles/scripts/install_pkgs.sh
~/dotfiles/scripts/install_pkgs.sh

cowsay 'yo we done!'
