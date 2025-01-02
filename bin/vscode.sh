#!/bin/zsh
set -eu

SOURCE_DIR=$(cd $(dirname $0) && pwd)/../vscode

# TODO Linux対応
# install settings
VSCODE_SETTING_DIR=~/Library/Application\ Support/Code/User
ln -fnsv "$SOURCE_DIR/settings.json" "${VSCODE_SETTING_DIR}/settings.json"
ln -fnsv "$SOURCE_DIR/keybindings.json" "${VSCODE_SETTING_DIR}/keybindings.json"

# install extentions
cat $SOURCE_DIR/extentions.txt | while read line
do
    # ignore blank or startswith #
    if [ -z "$line" ] || [ "${line:0:1}" = "#" ]; then
        continue
    fi
    code --install-extension $line
done
