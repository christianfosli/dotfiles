#!/bin/bash

# This includes CLI tools I use frequently
# Tools to install manually when applicable:
# docker, rust, texlive, etc

# Set variables
pkgs='skim neovim git curl'
gui_pkgs='chromium gnome-tweaks'
gui=0 # make 0 if no gui

if hash apt; then
    install_cmd='apt install -y'
elif hash dnf; then
    install_cmd='dnf install -y'
elif hash apk; then
    install_cmd='apk add'
else
    echo "ERR: could not determine package manager" && exit 1
fi

# Install non-gui apps
printf '\n\ninstalling packages\n\n'
for pkg in $pkgs; do
    printf "installing $pkg\n"
    $install_cmd $pkg \
        || (echo "ERR: Failed on install $pkg" && exit 1)
done

# Install gui apps
if [[ $gui -eq 1 ]]; then
    printf '\n\ninstalling gui apps\n\n'
    for gui_pkg in $gui_pkgs; do
        sudo $pkgManager install -y $gui_pkg \
            || (echo "ERR: Failed to install $pkg" && exit 1)
    done
fi
