#!/bin/bash
set -eo pipefail

pkgs='skim neovim git curl ripgrep'
workstation_pkgs='gnome-tweaks alacritty'
workstation_flatpaks="com.getpostman.Postman com.microsoft.Teams org.chromium.Chromium \
org.gimp.GIMP"

if hash apt; then
    install_cmd='apt install -y'
elif hash dnf; then
    install_cmd='dnf install -y'
elif hash apk; then
    install_cmd='apk add'
else
    echo "ERR: could not determine package manager" && exit 1
fi

# --- Install packages ---

printf '\n\ninstalling packages\n\n'
for pkg in $pkgs; do
    printf "installing $pkg\n"
    $install_cmd $pkg
done

# --- Prompt for ``workstation packages'' ---

printf '\n\nInstall packages for workstation?\n'
select yn in "yes" "no"; do
    case $yn in
        yes)
            printf '\n\nInstalling workstation packages\n\n'
            for pkg in $workstation_pkgs
            do
                printf 'Installing %s\n' $pkg
                $install_cmd $pkg
            done

            printf '\n\nInstalling workstation flatpaks\n\n'
            for pkg in $workstation_flatpaks
            do
                printf 'Installing %s\n' $pkg
                flatpak install flathub $pkg
            done

            # List of things I have done in case of a clean-install
            printf 'You need to install programming languages manually { Rust, dotnet, ... } \n'
            printf 'You need to install tools that have their own yum repositories yourself also\n'
            printf 'Like VSCode, Docker, Kubernetes, Azure-CLI\n'
            printf 'You need to set SELinux to permissive to use bind mounts in docker with ease\n'
            printf 'You need to log in with X instead of Wayland to screenshare on MS Teams\n'
            printf 'You need to use dotnet cli to generate a self-signed PFX and set some env vars\n'
            printf 'to run dotnet applications with https in docker\n'
            printf 'You need to install azure artifacts cred-provider to work with private Nuget feeds\n'
            ;;
        no)
            exit
            ;;
    esac
done
