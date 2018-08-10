#!/bin/bash

# TODO: Check pkgs

# Install applicable stuffs from apt-get
echo 'About to install some stuff from apt-get, will need a password in a sec'
pkgs = 'cowsay default-jre default-jdk lftp nodejs npm pandoc python3 python3-dev screenfetch texlive xdg-tools'
for pkg in $pkgs
do
	sudo apt-get -y install $pkg
done

# Install applicable stuffs from pip3
pip3 install python-language-server[all]

# Install applicable stuff from npm
sudo npm install -g wsl-open
