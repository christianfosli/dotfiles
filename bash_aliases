#!/bin/bash
# My Aliases!

# Make this file work also for non-login shells (i.e vim terminal):
shopt -s expand_aliases

# Copied from default Ubuntu bashrc:
# Note: Mac OS version of ls doesnt support --color=auto
if [ "$(uname -s)" != "Darwin" ]; then
    alias ls='ls --color=auto'
fi
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Added myself: --------------------------

alias syncpls='~/dotfiles/scripts/sync.sh'

# On fedora (and several linux distros) included vim doesn't include
# clipboard support. Fix is to install gvim and use gvim -v instead
if hash vimx 2> /dev/null; then
    alias vim='vimx'
fi

# Alias see to xdg-open on fedora
if hash xdg-open 2> /dev/null && ! hash see 2> /dev/null; then
    alias see='xdg-open'
# Alias see to open on mac os
elif hash open 2> /dev/null && ! hash see 2> /dev/null; then
    alias see='open'
fi
