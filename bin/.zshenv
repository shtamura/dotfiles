SCRIPT_DIR=$(cd $(dirname $0) && pwd)
SOURCE_DIR=${$(dirname "$(readlink -f "$SCRIPT_DIR/.zshenv")")//\/bin/}
export ZDOTDIR=$SOURCE_DIR/zsh
