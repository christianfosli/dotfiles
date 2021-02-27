#!/bin/bash

# --- Helper Functions ---

put_plugin() {
    # Convenience function for installing or updating a plugin from a git repo
    # See `:help packages` in vim/neovim for details
    local path="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/pack/$1"
    local repo="$2"

    if [[ -d "$path" ]]; then
        printf '\nUpdating plugin %s\n' "$1"
        cd "$path"
        git pull
    else
        printf '\nInstalling plugin %s\n' "$1"
        mkdir -p "$path"
        git clone "$repo" "$path"
        if [[ -d "$path/doc" ]]; then
            printf 'Adding docs for %s as to :help\n' "$1"
            nvim -u NONE -c "helptags $path/doc" -c q
        else
            printf '%s does not have docs\n' "$1"
        fi
    fi
}

# --- Setup Script ---

set -eo pipefail

printf 'Checking if .spl file is up-to-date\n'
spellfile_path='~/.config/nvim/spell/en.utf-8.add'
if [[ -f "$spellfile_path" && "$spellfile_path.spl" -ot "$spellfile_path"  ]]; then
    printf '.spl file must be updated\n'
    nvim --headless -c 'mkspell! ~/.config/nvim/spell/en.utf-8.add' -c q
else
    printf '.spl file is up-to-date\n'
fi

printf '\nInstalling language servers...\n'
printf '...for python\n'
npm i -g pyright
printf '\n...and typescript\n'
npm i -g typescript typescript-language-server
cd ~/.local/bin
printf '\n...and rust\n'
curl -LOf https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-linux.gz \
    && gunzip -f rust-analyzer-linux.gz \
    && chmod +x rust-analyzer
# TODO: CSharp (omnisharp) and FSharp (fsautocomplete)
cd -

printf '\nUpdating plugins...\n'
put_plugin 'christianfosli/start/wsl-copy' 'git@github.com:christianfosli/wsl-copy.git'
put_plugin 'hashivim/start/vim-terraform' 'git@github.com:hashivim/vim-terraform.git'
put_plugin 'tpope/start/sleuth' 'https://tpope.io/vim/sleuth.git'
put_plugin 'neovim/start/nvim-lspconfig' 'git@github.com:neovim/nvim-lspconfig.git'
put_plugin 'nvim-tresitter/start/nvim-tresitter' 'git@github.com:nvim-treesitter/nvim-treesitter.git'
printf '^^ If there was updates to nvim-tresitter pls run `:TSUpdate` to update the parsers\n'

printf '\nnvim-tresitter requires c++ compiler\n'
dnf list installed gcc-c++ || (
    printf 'no c++ compiler found. installing gcc-c++\n' && sudo dnf install gcc-c++
)