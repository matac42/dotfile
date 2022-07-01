# set color
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

# show current dir
PROMPT="%{$fg[green]%}[%~]%{$reset_color%}\$vcs_info_msg_0_
%(!.#.$)"

# alias
alias ls="ls -GF"
alias la="ls -la"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias c="code ."
alias crslide="slideshow build -t s6cr slide.md && open slide.html"

#zsh auto complete
autoload -Uz compinit
compinit

# history
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=1000000

# share .zshhistory
setopt inc_append_history
setopt share_history

# useOpenSSL
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
