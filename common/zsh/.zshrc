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

  plugins=(archlinux brew bun dotnet eza fzf gh git ng terraform tmux tmuxinator vi-mode vscode zoxide zsh-interactive-cd)

  # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vi-mode#settings
  VI_MODE_SET_CURSOR=true

  # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/terraform#prompt-function
  RPROMPT='$(tf_prompt_info)'
  RPROMPT='$(tf_version_prompt_info)'

  # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vscode#choosing-an-editor
  VSCODE=code-insiders

  source $ZSH/oh-my-zsh.sh
fi

if (( $+commands[claude] )); then
  alias claude-personal='CLAUDE_CONFIG_DIR="$HOME/.claude-personal" command claude'
  alias claude-bethel='CLAUDE_CONFIG_DIR="$HOME/.claude-bethel" command claude'

  claude() {
    local choice
    choice=$(printf 'personal\nbethel\n' | fzf --prompt="Select Claude account > " --height=~10 --layout=reverse)

    case "$choice" in
      personal)
        CLAUDE_CONFIG_DIR="$HOME/.claude-personal" command claude
        ;;
      bethel)
        CLAUDE_CONFIG_DIR="$HOME/.claude-bethel" command claude
        ;;
      *)
        echo "No selection made, aborting."
        return 1
        ;;
    esac
  }
fi
(( $+commands[ctags] )) && alias tag="ctags -R ."
if (( $+commands[eza] )); then
  alias l="eza -l --git"
  alias ll="eza -ahl --git"
fi
if (( $+commands[fzf] )); then
   export FZF_DEFAULT_OPTS="
    --color=fg:#878580,bg:#100F0F,hl:#CECDC3
    --color=fg+:#878580,bg+:#1C1B1A,hl+:#CECDC3
    --color=border:#AF3029,header:#CECDC3,gutter:#100F0F
    --color=spinner:#24837B,info:#24837B,separator:#1C1B1A
    --color=pointer:#AD8301,marker:#AF3029,prompt:#AD8301"
fi
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

dev() {
  local template="${1:-dev}"
  local repo
  repo=$(fd -HI '^\.git$' ~/dev -x dirname {} | sort -u | fzf --prompt="Select repo > " --height=40% --border --reverse)

  [[ -z "$repo" ]] && return 1

  local name
  name=$(basename "$repo")

  DEV_REPO_ROOT="$repo" DEV_REPO_NAME="$name" tmuxinator start "$template"
}

[[ -f $HOME/.zshrc.linux ]] && source $HOME/.zshrc.linux
[[ -f $HOME/.zshrc.macos ]] && source $HOME/.zshrc.macos
[[ -f $HOME/.zshrc.local ]] && source $HOME/.zshrc.local
