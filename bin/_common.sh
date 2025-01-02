#!/bin/zsh

function exit_if_not_macos() {
    if [ "$(uname)" != "Darwin" ] ; then
        echo "Not macOS!"
        exit 1
    fi
}

function install_command_if_not_installed() {
    command=$1
    alias=${2:-$command}
    eval_to_install=${3:-}

    if ! which $command &> /dev/null ; then
        echo "$command is not installed"
        if [ -n "$eval_to_install" ] ; then
            eval $eval_to_install
        else
            if which brew &> /dev/null ; then
                brew install $alias
            elif which apt &> /dev/null ; then
                # has apt
                apt install -y $alias
            else
                # others. exit 1
                echo "$(uname) is not supported. use Homebrew or apt"
                exit 1
            fi
        fi
    else
        echo "$1 is already installed"
    fi
}
