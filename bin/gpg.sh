#!/bin/zsh
set -eu

echo "pinentry-program $(which pinentry-mac)" > ~/.gnupg/gpg-agent.conf
