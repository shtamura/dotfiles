#!/bin/bash
set -eu

SCRIPT_DIR=$(cd $(dirname $0) && pwd)
. $SCRIPT_DIR/_common.sh

# Install and enable zsh
if [ $SHELL != "/usr/bin/zsh" ] ; then
    install_command_if_not_installed zsh
    chsh -s $(which zsh)
    zsh
    export SHELL=$(which zsh)
else
    echo "zsh is already set"
fi

install_command_if_not_installed sudo
install_command_if_not_installed vim
install_command_if_not_installed curl
install_command_if_not_installed git
install_command_if_not_installed apt-transport-https
install_command_if_not_installed ca-certificates
install_command_if_not_installed gnupg
install_command_if_not_installed zip
install_command_if_not_installed unzip
