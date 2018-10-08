#!/bin/bash
# file: ~/.bash_aliases  (sourced from ~/.bashrc)
# author: Christian Fosli <cfosli@gmail.com>

# Get some colors (Most are from default ubuntu .bashrc)
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Fix command like in vim command line window
alias q:=fc

# Mac / Linux specific
if [[ "$(uname -s)" == "Darwin" ]]; then # Mac-only aliases:
        hash /usr/local/bin/vim 2> /dev/null && alias vim=/usr/local/bin/vim
        alias see='open'
        alias ls='ls -G'
else    # Linux-only aliases (not supported on Mac OS)
        # On most distros vim doesn't have clipboard support, but vimx does
        hash vimx 2> /dev/null && alias vim='vimx'
        alias ls='ls --color=auto'
        alias ip='ip --color'
        alias cal='cal --monday'
        hash see 2> /dev/null || alias see='xdg-open'
fi

# Script to sync onedrive and google drive
alias syncpls='~/dotfiles/scripts/sync.sh'
