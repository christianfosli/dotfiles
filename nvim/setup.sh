#!/bin/bash

# --- Helper Functions ---

put_plugin() {
    # Convenience function for installing or updating a plugin from a git repo
    # See `:help packages` in vim/neovim for details
    local path="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/pack/$1"
    local repo="$2"
    local updated=false

    if [[ -d "$path" ]]; then
        printf '\nChecking for updates for %s\n' "$1"
        cd "$path"
        git fetch
        if [[ "$(git rev-parse HEAD)" == $(git rev-parse origin) ]]; then
            printf 'No changes\n'
        else
            printf 'Changes found\n'
            git rebase origin
            updated=true
        fi
    else
        printf '\nInstalling plugin %s\n' "$1"
        mkdir -p "$path"
        git clone "$repo" "$path"
        updated=true
    fi

    if [[ updated && -d "$path/doc" ]]; then
        printf 'Adding/updating docs for %s\n' "$1"
        nvim --headless -u NONE -c "helptags $path/doc" -c q
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
pushd ~/.local/bin
printf '\n...and rust\n'
curl -LOf https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-linux.gz \
    && gunzip -f rust-analyzer-linux.gz \
    && mv rust-analyzer-* rust-analyzer
    && chmod +x rust-analyze
popd
pushd ~/.local/lib
printf '\n...and fsharp\n'
curl -LOf https://github.com/fsharp/FsAutoComplete/releases/latest/download/fsautocomplete.netcore.zip \
    && (rm -rf fsautocomplete || true) \
    && unzip fsautocomplete.netcore.zip -d fsautocomplete \
    && rm fsautocomplete.netcore.zip
    && pushd fsautocomplete
    && printf 'fixing permissions for fsautocomplete (workaround for issue #715)\n'
    && find . -type f -exec chmod 644 {} \;
    popd
popd

printf '\nUpdating plugins...\n'
put_plugin 'christianfosli/start/wsl-copy' 'git@github.com:christianfosli/wsl-copy.git'
put_plugin 'hashivim/start/vim-terraform' 'git@github.com:hashivim/vim-terraform.git'
put_plugin 'tpope/start/sleuth' 'https://tpope.io/vim/sleuth.git'
put_plugin 'neovim/start/nvim-lspconfig' 'git@github.com:neovim/nvim-lspconfig.git'
put_plugin 'nvim-tresitter/start/nvim-tresitter' 'git@github.com:nvim-treesitter/nvim-treesitter.git'
printf '^^ If there was updates to nvim-tresitter pls run `:TSUpdate` to update the parsers\n'

printf '\nnvim-tresitter requires c++ compiler\n'
if hash dnf 2>/dev/null; then
    dnf list installed gcc-c++ || (
        printf 'no c++ compiler found. installing gcc-c++\n' && sudo dnf install gcc-c++
    )
elif hash apt 2>/dev/null; then
    apt list --installed g++ || (
        printf 'no c++ compiler found. installing g++\n' && sudo apt install g++
    )
fi
