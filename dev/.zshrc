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

(( $+commands[assume] )) && alias assume=". assume"
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
  source "$XDG_CONFIG_HOME/theming/colors.sh"
  source "$XDG_CONFIG_HOME/theming/appearance.sh"

  # Recomputed every prompt so a mid-session light/dark flip (macOS System
  # Settings, or the appearance watcher on a wake/sleep cycle) is picked up
  # without opening a new shell -- matches Ghostty's live switching.
  _theming_fzf_opts() {
    theming_colors "$(theming_mode)"
    export FZF_DEFAULT_OPTS="
    --color=fg:$THEME_TX_2,bg:$THEME_BG,hl:$THEME_TX
    --color=fg+:$THEME_TX_2,bg+:$THEME_BG_2,hl+:$THEME_TX
    --color=border:$THEME_RE_2,header:$THEME_TX,gutter:$THEME_BG
    --color=spinner:$THEME_CY_2,info:$THEME_CY_2,separator:$THEME_BG_2
    --color=pointer:$THEME_YE_2,marker:$THEME_RE_2,prompt:$THEME_YE_2"
  }
  _theming_fzf_opts
  autoload -Uz add-zsh-hook
  add-zsh-hook precmd _theming_fzf_opts
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

source $XDG_CONFIG_HOME/zsh/functions/dev.zsh
source $XDG_CONFIG_HOME/zsh/functions/syncdots.zsh

[[ -f $HOME/.zshrc.linux ]] && source $HOME/.zshrc.linux
[[ -f $HOME/.zshrc.macos ]] && source $HOME/.zshrc.macos
[[ -f $HOME/.zshrc.local ]] && source $HOME/.zshrc.local
