# 現在のスクリプトファイル (.zshenv) の絶対パスを取得
SCRIPT_PATH=${(%):-%x}
SOURCE_DIR=${$(dirname "$(readlink -f "$SCRIPT_PATH")")//\/bin/}
export ZDOTDIR=$SOURCE_DIR/zsh
