export ZSH="/home/sbi/.oh-my-zsh"

ZSH_THEME="lukerandall"

plugins=(emacs ripgrep)

source $ZSH/oh-my-zsh.sh

alias objdump="/usr/bin/objdump -Mintel"
alias disassemble="objdump -Cdr --visualize-jumps=color"
alias rm="/usr/bin/rm -i"
alias cp="/usr/bin/cp -i"
alias mv="/usr/bin/mv -i"
alias p="popd"
alias o="$PAGER"
alias v="gio open"

if [[ $INSIDE_EMACS =~ ,comint ]]; then
    export PAGER=cat
fi

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
