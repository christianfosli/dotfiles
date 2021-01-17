#!/bin/bash
set -eo pipefail

pkgs='skim neovim git curl'
workstation_pkgs='chromium-freeworld gnome-tweaks docker keepassxc'

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
            for pkg in $workstation_pkgs do;
                printf 'Installing $pkg\n'
                $install_cmd $pkg
            done
            # List of things I have done in case of a clean-install
            printf 'You need to install programming languages manually { Rust, dotnet, ... } \n'
            printf 'You need to install tools that have their own yum repositories yourself also\n'
            printf 'Like VSCode, Ms Teams, Kubernetes, Azure-CLI\n'
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
