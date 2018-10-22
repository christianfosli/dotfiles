# .bash_profile

# Get the aliases and functions
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Add applicable dirs to path (if they are not there already and they exist)
pathdirs="$HOME/.local/bin /usr/local/bin $HOME/bin $HOME/Library/Python/3.6/bin"
for p in $pathdirs; do
    if [[ $PATH != *:$p:* && -d $p ]]; then
        PATH=$PATH:$p
    fi
done
export PATH

# Set vim to default editor
if hash vimx 2> /dev/null; then # Use vimx if we have it
    export VISUAL=vimx
elif -f /usr/local/bin/vim 2> /dev/null; then # Use homebrew-vim on Mac OS
    export VISUAL=/usr/local/bin/vim
else
    export VISUAL=vim
fi
export EDITOR=$VISUAL

# Get better ls colors on Mac OS
if [[ "$(uname -s)" == "Darwin"  ]]; then
    export LSCOLORS='Exgxcxdxbxegedabagacad'
fi

# Don't color executables on WSL (as all windows files on /mnt/c are exec)
[[ -d /mnt/c ]] && export LS_COLORS="ex=0"
