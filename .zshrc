# Fig pre block. Keep at the top of this file.
. "$HOME/.fig/shell/zshrc.pre.zsh"
#色を使えるようにする
autoload colors
colors

# git
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{magenta}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}+"
zstyle ':vcs_info:*' formats "%F{cyan}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )

#カレントディレクトリの表示
#PROMPT="%{$fg[green]%}[${HOST%%.*} %1~]%(!.#.$)%{$reset_color%}"
PROMPT="%{$fg[green]%}[%~]%{$reset_color%}\$vcs_info_msg_0_
%(!.#.$)"

#エイリアス
alias ls="ls -GF"
alias la="ls -la"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias c="code ."
alias note="code ~/ws/notes"
alias crslide="slideshow build -t s6cr slide.md && open slide.html"
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias blog="perl /Users/matac/ws/bin/blog_post.pl"
alias mac="ifconfig en0 | awk '/ether/{print $2}'"

#前回最後に開いたディレクトリに自動移動
setopt NONOMATCH
autoload -Uz add-zsh-hook
add-zsh-hook chpwd chpwd_func
function chpwd_func() {
  sed -i -e "s:^cd .* #catcat:cd $PWD #catcat:g" ~/.zshrc
}
cd /Users/matac/ws/src/github.com/matac42/dotfile #catcat

#zshの補完機能を有効化
autoload -Uz compinit
compinit

# history
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=1000000

# share .zshhistory
setopt inc_append_history
setopt share_history

#接続しているwifiのssidを表示
# /System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I | grep "\sSSID" | tr -d ' '

#LibreSSLではなくOpenSSLを使用する．
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"

#export PATH="/Users/matac/b3_later/compiler/rust-build/bin:$PATH"

#gnuplotの設定
#export GNUTERM=aqua
#set terminal x11
#set terminal dumb
#set terminal jpeg
#set output "out.png"

# ghq管理のリポジトリパスをpecoに渡す．
function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

# pecoによるhistory検索の設定
function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

export fireflyhg="ssh://firefly/hg"

# Golang
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/ws/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOPATH/bin/darwin_arm64

# CbC
# export CBC_COMPILER=/Users/matac/ws/cr/CbC/CbC_gcc/build/bin/gcc
export CBC_COMPILER=/opt/homebrew/Cellar/cbclang/llvm10/bin/clang

export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
source $(brew --prefix nvm)/nvm.sh

# rbenv
[[ -d ~/.rbenv  ]] && \
  export PATH=${HOME}/.rbenv/bin:${PATH} && \
  eval "$(rbenv init -)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv/shims"
export PATH="$PYENV_ROOT:$PATH"
export PIPENV_PYTHON="$PYENV_ROOT/python"

# mkdir & cd
md () {
    mkdir $1
    cd $1
}

# uninstall command
uninstall () {
  spt play --uri spotify:track:0UaQPu8dlcZfzg9g7DUSkD
  sleep 68
  rm "$@"
}

# ucd command
ucd () {
  spt play --uri spotify:track:3YbioJ807KAVVzY3NFdpF5
  sleep 40
  cd "$@"
}

# chAngE command
chAngE () {
  spt play --uri spotify:track:7McCOOQG8GQtngK2Obh0Ts
  sleep 60
  cd "$@"
}
export PATH="$HOME/.plenv/bin:$PATH"
eval "$(plenv init -)"

# Fig post block. Keep at the bottom of this file.
. "$HOME/.fig/shell/zshrc.post.zsh"

if [[ $TERM_PROGRAM == "vscode" ]] && [[ $(arch) == "arm64" ]];
then
  exec arch -x86_64 $SHELL
fi
