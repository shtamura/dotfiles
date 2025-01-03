#!/bin/zsh
set -eu

SCRIPT_DIR=$(cd $(dirname $0) && pwd)
. $SCRIPT_DIR/_common.sh

# git
curl -o $SCRIPT_DIR/../zsh/.zsh/git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
curl -o $SCRIPT_DIR/../zsh/.zsh/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
curl -o $SCRIPT_DIR/../zsh/.zsh/_git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh

# bat
install_command_if_not_installed bat
if [[ -f /usr/bin/batcat && ! -f /usr/bin/bat ]]; then
    ln -s /usr/bin/batcat /usr/bin/bat
fi

# eza
install_command_if_not_installed eza

# delta
install_command_if_not_installed delta git-delta

# fd
install_command_if_not_installed fd fd-find
if [[ $(which fdfind) && -z `which fdfind` ]]; then
    ln -s `which fdfind` /usr/bin/fd
fi

# fzf
install_command_if_not_installed fzf "" 'rm -rf ~/.local/bin/.fzf; \
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.local/bin/.fzf; \
~/.local/bin/.fzf/install --xdg; \
ln -s ~/.local/bin/.fzf/bin/fzf /usr/local/bin/fzf;'

# ripgrep
install_command_if_not_installed rg ripgrep

# zoxide
install_command_if_not_installed zoxide

# gh
install_command_if_not_installed gh

# awscli
install_command_if_not_installed aws awscli

# kubectl (x86)
# https://kubernetes.io/ja/docs/tasks/tools/install-kubectl-linux/
install_command_if_not_installed kubectl "" 'pushd /tmp; curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"; curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"; echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check; install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl; popd'

# uv
install_command_if_not_installed uv "" "curl -LsSf https://astral.sh/uv/install.sh | sh"

# # gcloud
# # https://cloud.google.com/sdk/docs/install?hl=ja#deb
# install_command_if_not_installed gcloud "" 'pushd /tmp; \
# curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg; \
# echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list; \
# apt update && apt install google-cloud-cli; \
# popd'
