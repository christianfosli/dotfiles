#!/bin/bash

# Install applicable stuffs from apt-get (replace with applicable package manager)
echo 'About to install some stuff from apt-get, will need a password in a sec'
pkgs = 'cowsay java-openjdk lftp nodejs npm pandoc python3 python3-dev rclone screenfetch texlive xdg-tools'

for pkg in $pkgs
do
	sudo apt-get -y install $pkg
done

# Install applicable stuffs from pip3
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
