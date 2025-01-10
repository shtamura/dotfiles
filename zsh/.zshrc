export LANG=ja_JP.UTF-8
umask 022
stty icrnl

# Editor
export EDITOR=vim
export VISUAL='vim'

# コンテナのビルダーを指定
export DOCKER_BUILDKIT=1

# 色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# -----------------------------
# コマンド履歴
# -----------------------------
HISTFILE=$HOME/.zsh_history
# on-memory history
HISTSIZE=1000
# on-disk history
SAVEHIST=10000
# 複数ウィンドウで履歴共有
setopt share_history

# -----------------------------
# zsh諸々
# -----------------------------
# 色を使用
autoload -Uz colors ; colors

# cdした際のディレクトリをディレクトリスタックへ自動追加
setopt auto_pushd

# ディレクトリスタックへの追加の際に重複させない
setopt pushd_ignore_dups

# フローコントロールを無効にする
setopt no_flow_control

# ワイルドカード展開を使用する
setopt extended_glob

# cdコマンドを省略して、ディレクトリ名のみの入力で移動
setopt auto_cd

# 自動でpushdを実行
setopt auto_pushd

# pushdから重複を削除
setopt pushd_ignore_dups

# ビープ音を鳴らさないようにする
# setopt no_beep

# カッコの対応などを自動的に補完する
setopt auto_param_keys

# ディレクトリ名の入力のみで移動する
setopt auto_cd

# bgプロセスの状態変化を即時に知らせる
setopt notify

# 8bit文字を有効にする
setopt print_eight_bit

# ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt mark_dirs

# コマンドライン全てのスペルチェックをする
setopt correct_all

# 上書きリダイレクトの禁止
setopt no_clobber

# パスの最後のスラッシュを削除しない
setopt noautoremoveslash

# 自動訂正を無効化
unsetopt correct_all

# -----------------------------
# 補完
# -----------------------------
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
zstyle ':completion:*:default' menu select=2

# 補完関数の表示を強化する
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT

# セパレータを設定する
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true

# 大文字小文字を区別しない（大文字を入力した場合は区別する）
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# マッチ種別を別々に表示
# zoxideの補完と干渉して Completing file グループが重複表示されるが、
# group-name分割は有用なのでグループ重複を許容する
zstyle ':completion:*' group-name ''

# 補完候補表示時にビープ音を鳴らさない
setopt nolistbeep

# 候補が多い場合は詰めて表示
setopt list_packed

# -----------------------------
# prompt
# -----------------------------
# %M    ホスト名
# %m    ホスト名
# %d    カレントディレクトリ(フルパス)
# %~    カレントディレクトリ(フルパス2)
# %C    カレントディレクトリ(相対パス)
# %c    カレントディレクトリ(相対パス)
# %n    ユーザ名
# %#    ユーザ種別
# %?    直前のコマンドの戻り値
# %D    日付(yy-mm-dd)
# %W    日付(yy/mm/dd)
# %w    日付(day dd)
# %*    時間(hh:flag_mm:ss)
# %T    時間(hh:mm)
# %t    時間(hh:mm(am/pm))
# git prompt
. $ZDOTDIR/.zshrc_git
setopt prompt_subst
PS1='%T %F{green}%c%f $(git_color)$(__git_ps1 "%s")%f $ '

# -----------------------------
# alias
# -----------------------------
. $ZDOTDIR/.zshrc_alias

# -----------------------------
# tools
# -----------------------------
# python
export PYTHONDONTWRITEBYTECODE=1
export PYTHONPATH=.:$PYTHONPATH

# awscli
if ! which aws_completer &> /dev/null ; then
  # ubuntu
  ln -s /usr/libexec/aws_completer /usr/local/bin/aws_completer
fi
complete -C `which aws_completer` aws

# gcloud
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then
  . "$HOME/google-cloud-sdk/path.zsh.inc"
fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then
  . "$HOME/google-cloud-sdk/completion.zsh.inc"
fi

# fzf
if which fzf &> /dev/null ; then
  source <(fzf --zsh)
  export FZF_TMUX_HEIGHT=100
  export FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
  export FZF_CTRL_T_OPTS='--preview "bat --color=always --style=header,grid --line-range :100 {}"'
fi

# zoxide
eval "$(zoxide init zsh)"

# uv
if [ -f "$HOME/.local/bin/env" ]; then
  . "$HOME/.local/bin/env"
fi

# pyenv
if which pyenv &> /dev/null ; then
  export PYENV_ROOT="$HOME/.pyenv"
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init - zsh)"
fi

# # completion
# fpath=(
#   ${HOME}/.zsh/completions
#   ${fpath}
# )
# autoload -Uz compinit
# compinit
# # 
# # terraform completion
# # autoload -U +X bashcompinit && bashcompinit
# # complete -o nospace -C /opt/homebrew/Cellar/tfenv/2.2.3/versions/1.4.2/terraform terraform

# # nodenv
# export PATH=$PATH:/opt/homebrew/Cellar/nodenv/1.4.1/bin
# eval "$(nodenv init -)"

# #azure cli
# autoload -Uz +X bashcompinit && bashcompinit
# if [ -f "$HOME/.zsh/completions/az.completion" ]; then
#   source $HOME/.zsh/completions/az.completion
# fi

# # goenv
# export GOENV_ROOT=$HOME/.goenv
# export PATH=$GOENV_ROOT/bin:$PATH
# eval "$(goenv init -)"

[ -f $ZDOTDIR/.zsh/.zshrc.local ] && . $ZDOTDIR/.zsh/.zshrc.local
