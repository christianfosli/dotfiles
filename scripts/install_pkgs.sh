#!/bin/bash

# Set variables
pkgs='cowsay java-openjdk-devel lftp nodejs npm pandoc python3 python3-devel rclone screenfetch texlive xdg-tools'
gui_pkgs='chromium gnome-tweaks'
gui=1 # make 0 if no gui
wsl=0 # make 1 of on wsl
pkgManager='dnf'

echo 'WARNING: Please ensure variables are properly set in script file'
echo 'If not cancel script with Ctrl-C and edit script file'
printf 'Current values: GUI=%d, WSL=%d, pkgManager=%s\n' $gui $wsl $pkgManager
sleep 5s

# Install non-gui apps
echo 'installing applicables from your package manager - will need password'
for pkg in $pkgs; do
	sudo $pkgManager install -y $pkg
done

# Install gui apps
if ($gui == 1); then
    echo 'installing gui apps'
    for gui_pkg in $gui_pkgs; do
        sudo $pkgManager install -y $gui_pkg
    done
fi

# Install applicable stuffs from pip3
echo 'installing applicables from pip'
pip3 install python-language-server[all]

# Install applicable stuff from NPM
if [ $wsl == 1 ]; then
    echo 'installing wsl-open'
    sudo npm install -g wsl-open
fi

# Fix java version (requires used input)
# ref https://fedoraproject.org/wiki/Java switching java versions is done
# using the alternatives system
echo 'if there are installed several java versions u need to specify'
echo 'which one to use. Opening `alternatives --config java` '
alternatives --config java
