# ~/.bashrc: executed by bash for non-login shells.

# Source global definitions
[[ -f /etc/bashrc ]] && . /etc/bashrc

# User specific aliases and functions

# Source git-prompt.sh to enable it for bash prompt
if [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
    source /usr/share/git-core/contrib/completion/git-prompt.sh
elif [ -f /usr/local/etc/bash_completion.d/git-prompt.sh ]; then
    source /usr/local/etc/bash_completion.d/git-prompt.sh 
fi

# Bash prompt, based on fedora default, but with color and git branch!
PS1='\[\e[0;32m\][\u@\h \W$(__git_ps1 2>/dev/null " 🌳%s")]\[\e[m\] \$ '
# note non-printing parts are escaped inside \[ ... \] so readline knows PS1 length

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add ~/.local/bin to path
[[ -d ~/.local/bin ]] && export PATH+='~/.local/bin'

# Set vim to default editor (use vimx if we have it)
hash vimx 2> /dev/null && export VISUAL=vimx || export VISUAL=vim
export EDITOR=$VISUAL

# Alias definitions
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

# Open tmux if not already in tmux
[[ $TERM == screen* || $TERM == tmux* ]] || tmux
