#!/usr/bin/bash

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

shopt -s direxpand

export ALTERNATE_EDITOR=vim
export EDITOR="emacsclient -t"
export VISUAL="emacsclient -c -a emacs"
export PAGER=less

if [[ $INSIDE_EMACS =~ ,comint ]]; then
    export PAGER=cat
fi

set -o noclobber

PS1='\\$ '

function messdir () {
    printf "$HOME/mess/%(%Y/%W)T\n"
}

# mess and the c (pushd) and p (popd) aliases break directory tracking
# in the EMACS shell.
function mess () {
    local C
    local M
    M="$(messdir)"
    C="$HOME/mess/current"
    if [[ $(readlink $C) != $M ]]; then
	mkdir -p $M
	rm -f $C
	ln -s $M $C
    fi
    pushd $C
}

alias objdump="/usr/bin/objdump -Mintel"
alias disassemble="objdump -Cdr --visualize-jumps=color"
alias grep="/usr/bin/grep --color=auto"
alias egrep="/usr/bin/egrep --color=auto"
alias fgrep="/usr/bin/fgrep --color=auto"
alias rgrep="/usr/bin/rgrep --color=auto"
alias ls="ls --color=auto -F"
alias rm="/usr/bin/rm -i"
alias cp="/usr/bin/cp -i"
alias mv="/usr/bin/mv -i"
alias c="pushd"
alias p="popd"
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

# opam configuration
test -r /home/sbi/.opam/opam-init/init.sh && . /home/sbi/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

export RUST_BACKTRACE=1
[ -f "/home/sbi/.ghcup/env" ] && source "/home/sbi/.ghcup/env" # ghcup-env

# docker rootless configuration
if [[ -v XDG_RUNTIME_DIR ]]; then
    export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
fi

function sage () {
    docker run -v "$PWD:/home/sage/data" -it sagemath/sagemath:latest
}

function sage_nb () {
    docker run -v "$PWD:/home/sage/data" -p8888:8888 sagemath/sagemath:latest sage-jupyter
}

function R () {
    docker run -v "$PWD:/home/docker" -it --rm r-base:latest
}

# NB. There is an issue in docker: rootless mode and the overlay2
# storage driver don't work with some containers. My current docker
# config is
#
#     {
#         "storage-driver": "fuse-overlayfs",
#         "data-root": "$HOME/docker_data"
#     }
