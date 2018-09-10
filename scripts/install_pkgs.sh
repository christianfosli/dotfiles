#!/bin/bash

# Check which package manager to use
if hash apt-get; then
    packageManager='apt-get'
    apt-get update
else if hash dnf; then
    packageManager='dnf'
else
    echo 'Unable to figure out which package manager to use'
    echo 'Please Ctrl-C to cancel, and edit script file'
fi

# Install applicable stuffs
echo 'installing applicables from your package manager -- will need password'
pkgs = 'cowsay java-openjdk lftp nodejs npm pandoc python3 python3-devel rclone screenfetch texlive xdg-tools'

for pkg in $pkgs
do
	sudo $packageManager install -y $pkg
done

# Install applicable stuffs from pip3
echo 'installing applicables from pip'
pip3 install python-language-server[all]

# Install applicable stuff from NPM
echo '*PLZ* answer No if your are not on Windows Subsystem for Linux::'
read -p 'Do u wanna install wsl-open?' shouldInstall
if [ $shouldInstall == y ]; then
    echo 'installing wsl-open'
    sudo npm install -g wsl-open
else
    echo 'skipping wsl'
fi

# Fix java version (requires used input)
# ref https://fedoraproject.org/wiki/Java switching java versions is done
# using the alternatives system
echo 'if there are installed several java versions u need to specify'
echo 'which one to use. Opening `alternatives --config java` '
alternatives --config java
