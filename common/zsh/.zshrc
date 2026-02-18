#!/usr/bin/env zsh

# If not running interactively, don't do anything
[[ -o interactive ]] || return

if [[ -n $GHOSTTY_RESOURCES_DIR ]]; then
  source "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration
fi

if [[ -d "$HOME/.oh-my-zsh" ]]; then
  export ZSH="$HOME/.oh-my-zsh"
  ZSH_THEME=robbyrussell
  source $ZSH/oh-my-zsh.sh
else
  autoload -Uz compinit
  compinit -d "$ZSH_COMPDUMP"
fi

[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

(( $+commands[mise] )) && eval "$(mise activate zsh)"

(( $+commands[code-insiders] )) && alias codei="codei"
if (( $+commands[dotnet] )); then
  alias d=dotnet
  alias dr="dotnet run"
  alias df="dotnet format"
fi
(( $+commands[ctags] )) && alias tag="ctags -R ."
if (( $+commands[eza] )); then
  alias ls=eza
  alias l="eza -l --git"
  alias ll="eza -ahl --git"
fi
if (( $+commands[fzf] )); then
  source <(fzf --zsh)
  # upstream: https://github.com/vague-theme/vague-fzf/blob/main/vague
  export FZF_DEFAULT_OPTS="""
  --color=fg:#cdcdcd
  --color=bg:#141415
  --color=hl:#f3be7c
  --color=fg+:#aeaed1
  --color=bg+:#252530
  --color=hl+:#f3be7c
  --color=border:#606079
  --color=header:#6e94b2
  --color=gutter:#141415
  --color=spinner:#7fa563
  --color=info:#f3be7c
  --color=pointer:#aeaed1
  --color=marker:#d8647e
  --color=prompt:#bb9dbd
  """
fi
(( $+commands[gh] )) && alias ghas="gh auth switch"
if (( $+commands[git] )); then
  alias g=git
  alias ga="git add"
  alias gb="git switch"
  alias gbc="git switch -c"
  alias gc="git commit -m"
  alias gca="git commit -am"
  alias gd="git diff"
  alias gp="git pull"
  alias gP="git push"
  alias gr="git restore"
  alias gs="git status"
fi
(( $+commands[lazygit] )) && alias lg=lazygit
if (( $+commands[nvim] )); then
  export EDITOR="nvim"
  alias v="nvim"
  alias vs="nvim -S"
fi
(( $+commands[opencode] )) && alias oc=opencode
if (( $+commands[tmux] )); then
  alias t=tmux
  alias ta="tmux attach"
  alias tks="tmux kill-server"
fi
(( $+commands[wget] )) && alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
(( $+commands[yazi] )) && alias y=yazi

if (( $+commands[ng] )); then
  source <(ng completion script)
  alias ngr="ng serve"
  alias ngf="ng lint --fix"
fi

(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"

set -o vi

[[ -f $HOME/.zshrc.linux ]] && source $HOME/.zshrc.linux
[[ -f $HOME/.zshrc.macos ]] && source $HOME/.zshrc.macos
[[ -f $HOME/.zshrc.local ]] && source $HOME/.zshrc.local

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
