# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# set color
autoload colors
colors

# remind current dir
setopt NONOMATCH
autoload -Uz add-zsh-hook
add-zsh-hook chpwd chpwd_func
function chpwd_func() {
  sed -i -e "s:^cd .* #catcat:cd $PWD #catcat:g" ~/.zshrc
}
cd /Users/matac/ws/src/github.com/matac42/dotfile #catcat

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
PROMPT="%{$fg[green]%}[%~]%{$reset_color%}\$vcs_info_msg_0_
%(!.#.$) "

#エイリアス
alias ls="ls -GF"
alias la="ls -la"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias c="code ."
alias crslide="slideshow build -t s6cr slide.md && open slide.html"
alias mp="multipass"
alias gg="ghq get"
alias note="code ~/ws/notes"

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

#LibreSSLではなくOpenSSLを使用する．
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"

# ghq with peco
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

# history with peco
function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

export fireflyhg="ssh://firefly/hg"

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

# Golang
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

export PATH="$HOME/.plenv/bin:$PATH"
eval "$(plenv init -)"

# Terminal Logs
if [[ $TERM = screen ]] || [[ $TERM = screen-256color ]] ; then
  LOGDIR=$HOME/TerminalLogs
  LOGFILE=$(date +%Y-%m-%d_%H%M%S.log)
  [ ! -d $LOGDIR ] && mkdir -p $LOGDIR
  tmux  set-option default-terminal "screen" \; \
    pipe-pane        "cat >> $LOGDIR/$LOGFILE" \; \
    display-message  "Started logging to $LOGDIR/$LOGFILE"
fi

# tmux settings
if [[ ! -n $TMUX && $- == *l* ]]; then
  # get the IDs
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    tmux new-session
  fi
  create_new_session="Create New Session"
  ID="$ID\n${create_new_session}:"
  ID="`echo $ID | peco | cut -d: -f1`"
  if [[ "$ID" = "${create_new_session}" ]]; then
    tmux new-session
  elif [[ -n "$ID" ]]; then
    tmux attach-session -t "$ID"
  else
    :  # Start terminal normally
  fi
fi

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
