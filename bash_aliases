#!/bin/bash
# file: ~/.bash_aliases  (sourced from ~/.bashrc)
# author: Christian Fosli <cfosli@gmail.com>

# Make this file work also for non-login shells (i.e vim terminal):
shopt -s expand_aliases

# Get some colors (Most are from default ubuntu .bashrc)
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
# Mac version of ls doesnt support --color=auto, and dont have ip command
[[ "$(uname -s)" == "Darwin" ]] || { alias ls='ls --color=auto'; alias ip='ip --color'; }

# Script to sync onedrive and google drive
alias syncpls='~/dotfiles/scripts/sync.sh'

# Calendar should start on monday, not sunday (not supported on mac)
[ "$(uname -s)" == "Darwin" ] || alias cal='cal --monday'

# On fedora (and several linux distros) included vim doesn't include
# clipboard support. Fix is to install vim-x11 and use vimx instead
hash vimx 2> /dev/null && alias vim='vimx'

# Alias see to xdg-open on fedora, and to open on Mac os
if hash xdg-open 2> /dev/null; then
    hash see 2> /dev/null || alias see='xdg-open'
elif hash open 2> /dev/null; then
    hash see 2> /dev/null || alias see='open'
fi
