# ~/.bashrc: executed by bash for non-login shells.

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific aliases and functions

# Simple bash prompt with colors
PS1='\e[0;32m[\u@\h \W]\e[m\$ '

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add ~/.local to path
if [ -d ~/.local/bin ]; then
    export PATH+='~/.local/bin'
fi

# Set vim to default editor
if hash vimx; then
    export VISUAL=vimx
else
    export VISUAL=vim
fi
export EDITOR=$VISUAL

# Alias definitions
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Open GNU Screen if not already in Sreen
# use cut to make screen.xterm-256 -> screen
cutTermStr=$(echo $TERM | cut -d'.' -f 1)
if [[ $cutTermStr != 'screen' ]]; then
    screen
fi
