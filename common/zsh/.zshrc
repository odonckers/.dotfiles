#!/usr/bin/env zsh

# If not running interactively, don't do anything
[[ -o interactive ]] || return

if [[ -n $GHOSTTY_RESOURCES_DIR ]]; then
  source "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration
fi

if [[ -d "$HOME/.oh-my-zsh" ]]; then
  export ZSH="$HOME/.oh-my-zsh"

  ZSH_THEME=robbyrussell
  ZSH_DISABLE_COMPFIX=true

  plugins=(archlinux brew bun dotnet eza fzf gh git mise ng nvm terraform tmux vi-mode zoxide zsh-interactive-cd)

  # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/nvm#lazy-startup
  zstyle ':omz:plugins:nvm' lazy yes
  zstyle ':omz:plugins:nvm' lazy-cmd eslint prettier typescript ng jetpack

  # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vi-mode#settings
  VI_MODE_SET_CURSOR=true

  # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/terraform#prompt-function
  RPROMPT='$(tf_prompt_info)'
  RPROMPT='$(tf_version_prompt_info)'

  source $ZSH/oh-my-zsh.sh
fi

(( $+commands[code-insiders] )) && alias codei="codei"
(( $+commands[ctags] )) && alias tag="ctags -R ."
if (( $+commands[eza] )); then
  alias l="eza -l --git"
  alias ll="eza -ahl --git"
fi
(( $+commands[gh] )) && alias ghas="gh auth switch"
(( $+commands[lazygit] )) && alias lg=lazygit
if (( $+commands[ng] )); then
  alias ngr="ng serve"
  alias ngf="ng lint --fix"
fi
if (( $+commands[nvim] )); then
  export EDITOR="nvim"
  alias v="nvim"
  alias vs="nvim -S"
fi

[[ -f $HOME/.zshrc.linux ]] && source $HOME/.zshrc.linux
[[ -f $HOME/.zshrc.macos ]] && source $HOME/.zshrc.macos
[[ -f $HOME/.zshrc.local ]] && source $HOME/.zshrc.local

# bun completions

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
