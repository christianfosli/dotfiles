#!/bin/bash
# file: ~/.bash_aliases  (sourced from ~/.bashrc)
# author: Christian Fosli <cfosli@gmail.com>
shopt -s expand_aliases

# Get some colors (Most are from default ubuntu .bashrc)
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Fix command like in vim command line window
alias q:=fc

# Mac / Linux / Windows (git-bash) specific
if [[ "$(uname -s)" == "Darwin" ]]; then     # Mac-only:
    hash /usr/local/bin/vim 2> /dev/null && alias vim=/usr/local/bin/vim
    alias see='open'
    alias ls='ls -G'
elif [[ "$(uname -s)" == "MINGW64"* ]]; then # Git-bash only:
    alias see='start'
else    # Linux-only aliases (use vimx to get clipboard support)
    hash vimx 2> /dev/null && alias vim='vimx'
    alias ls='ls --color=auto'
    alias ip='ip --color'
    alias cal='ncal -bMw'
    hash see 2> /dev/null || alias see='xdg-open'
fi

# Script to sync onedrive and google drive
alias syncpls='~/dotfiles/scripts/sync.sh'
