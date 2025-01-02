#!/bin/zsh
set -eu

SCRIPT_DIR=$(cd $(dirname $0) && pwd)
. $SCRIPT_DIR/_common.sh

exit_if_not_macos

function open_app_store {
  echo "Please login with your Apple ID"
  sleep 1; echo "Open the App Store."
  sleep 1; open -a App\ Store
}

function login_check {
  while true; do
    echo -n "$* [Y/n]: (default: n) "
    read ANS
    case $ANS in
      [Yy]*)
        return 0
        ;;
      *)
        open_app_store
        ;;
    esac
  done
}

open_app_store
if login_check "Did you login?"; then
  brew bundle --global
fi
