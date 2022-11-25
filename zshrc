#!/usr/bin/zsh

export ZSH="/home/sbi/.oh-my-zsh"

ZSH_THEME="lukerandall"

plugins=(emacs ripgrep fzf)

source $ZSH/oh-my-zsh.sh
alias objdump="/usr/bin/objdump -Mintel"
alias disassemble="objdump -Cdr --visualize-jumps=color"
alias rm="/usr/bin/rm -i"
alias cp="/usr/bin/cp -i"
alias mv="/usr/bin/mv -i"
alias p="popd"
alias o="bat"
alias v="gio open"

bindkey '\e#' pound-insert

if [[ $INSIDE_EMACS =~ ,comint ]]; then
    export PAGER=cat
    alias o=cat
fi

export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# -F: quit if output is a single screen
# -q: quiet mode
# -R: print escape sequences

export LESS="-FqR"

function messdir () {
    printf "$HOME/mess/$(date +%Y/%W)\n"
}

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

# opam configuration
test -r /home/sbi/.opam/opam-init/init.sh && . /home/sbi/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

export RUST_BACKTRACE=1
[ -f "/home/sbi/.ghcup/env" ] && source "/home/sbi/.ghcup/env" # ghcup-env

function sage () {
    podman run -v "$PWD:/home/sage/data" -it docker.io/sagemath/sagemath:latest
}

function sage_nb () {
    podman run -v "$PWD:/home/sage/data" -p8888:8888 docker.io/sagemath/sagemath:latest sage-jupyter
}

function R () {
    podman run -v "$PWD:/home/docker" -it --rm docker.io/r-base:latest
}
