#!/usr/bin/env zsh

export XDG_CONFIG_HOME="$HOME/.config" && mkdir -p $XDG_CONFIG_HOME
export XDG_DATA_HOME="$HOME/.local/share" && mkdir -p $XDG_DATA_HOME
export XDG_STATE_HOME="$HOME/.local/state" && mkdir -p $XDG_STATE_HOME
export XDG_CACHE_HOME="$HOME/.cache" && mkdir -p $XDG_CACHE_HOME
export XDG_RUNTIME_DIR="$HOME/.local/run/$UID" && mkdir -p $XDG_RUNTIME_DIR

mkdir -p "$XDG_STATE_HOME/zsh"
export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
export HISTFILE="$XDG_STATE_HOME/zsh/history"

# node
[[ -d "$XDG_CONFIG_HOME/nvm" ]] && export NVM_DIR="$XDG_CONFIG_HOME/nvm"

# rust
[[ -f $HOME/.cargo/env ]] && source "$HOME/.cargo/env"

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.go/bin"
export PATH="$PATH:$HOME/.dotnet/tools"
export PATH="$PATH:$HOME/.aspire/bin"
export PATH="$PATH:$HOME/.opencode/bin"

[[ -f $HOME/.zshenv.linux ]] && source $HOME/.zshenv.linux
[[ -f $HOME/.zshenv.macos ]] && source $HOME/.zshenv.macos
[[ -f $HOME/.zshenv.local ]] && source $HOME/.zshenv.local
