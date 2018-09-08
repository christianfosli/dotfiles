#!/bin/bash
# My Aliases!

# Make this file work also for non-login shells (i.e vim terminal):
shopt -s expand_aliases

# Copied from default Ubuntu bashrc:
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Added myself: --------------------------

alias python="python3"

# On fedora (and several linux distros) included vim doesn't include
# clipboard support. Fix is to install gvim and use gvim -v instead
if [ -f /usr/bin/gvim ]; then
    alias vim='gvim -v'
fi

# Alias see to xdg-open on fedora
if hash xdg-open 2> /dev/null && ! hash see 2> /dev/null; then
    alias see='xdg-open'
# Alias see to open on mac os
elif hash open 2> /dev/null && ! hash see 2> /dev/null; then
    alias see='open'
fi

# End egne --------------------------------
