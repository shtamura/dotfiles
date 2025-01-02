#!/bin/zsh
set -eu

SCRIPT_DIR=$(cd $(dirname $0) && pwd)
. $SCRIPT_DIR/_common.sh

exit_if_not_macos

# Install xcode
set +e
xcode-select --install
set -e

# Install Homebrew
if which brew > /dev/null 2>&1; then
    echo "Homebrew is already installed"
else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
