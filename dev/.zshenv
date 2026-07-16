#!/usr/bin/env zsh

export XDG_CONFIG_HOME="$HOME/.config" && mkdir -p $XDG_CONFIG_HOME
export XDG_DATA_HOME="$HOME/.local/share" && mkdir -p $XDG_DATA_HOME
export XDG_STATE_HOME="$HOME/.local/state" && mkdir -p $XDG_STATE_HOME
export XDG_CACHE_HOME="$HOME/.cache" && mkdir -p $XDG_CACHE_HOME

# rust
[[ -f $HOME/.cargo/env ]] && source "$HOME/.cargo/env"

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.go/bin"
export PATH="$PATH:$HOME/.dotnet/tools"
export PATH="$PATH:$HOME/.aspire/bin"
export PATH="$PATH:$HOME/.opencode/bin"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

[[ -f $HOME/.zshenv.linux ]] && source $HOME/.zshenv.linux
[[ -f $HOME/.zshenv.macos ]] && source $HOME/.zshenv.macos
[[ -f $HOME/.zshenv.local ]] && source $HOME/.zshenv.local
