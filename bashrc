#!/usr/bin/bash

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

export ALTERNATE_EDITOR=vim
export EDITOR="emacsclient -t"
export VISUAL="emacsclient -c -a emacs"
export PAGER=less

set -o noclobber

PS1='\\$ '

alias grep="/usr/bin/grep --color=auto"
alias egrep="/usr/bin/egrep --color=auto"
alias fgrep="/usr/bin/fgrep --color=auto"
alias rgrep="/usr/bin/rgrep --color=auto"
alias ls="ls --color=auto -F"
alias rm="/usr/bin/rm -i"
alias cp="/usr/bin/cp -i"
alias mv="/usr/bin/mv -i"
alias o="$PAGER"
alias v="gio open"

if [[ -r $HOME/.dircolors ]]; then
    eval $(dircolors -b $HOME/.dircolors)
fi

if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi
