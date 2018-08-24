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

if hash open 2> /dev/null && ! hash see 2> /dev/null; then
	alias see='open'
fi

# End egne --------------------------------
