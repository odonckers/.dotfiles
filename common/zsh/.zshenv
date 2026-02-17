#!/usr/bin/env zsh

export XDG_CONFIG_HOME="$HOME/.config" && mkdir -p $XDG_CONFIG_HOME
export XDG_DATA_HOME="$HOME/.local/share" && mkdir -p $XDG_DATA_HOME
export XDG_STATE_HOME="$HOME/.local/state" && mkdir -p $XDG_STATE_HOME
export XDG_CACHE_HOME="$HOME/.cache" && mkdir -p $XDG_CACHE_HOME
export XDG_RUNTIME_DIR="$HOME/.local/run/$UID" && mkdir -p $XDG_RUNTIME_DIR

mkdir -p "$XDG_STATE_HOME/zsh"
export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
export HISTFILE="$XDG_STATE_HOME/zsh/history"

# rust
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
source "$XDG_DATA_HOME/cargo/env"

# go
export GOPATH="$XDG_DATA_HOME/go"

# dotnet
export DOTNET_CLI_HOME="$XDG_DATA_HOME"
export NUGET_PACKAGES="$XDG_CACHE_HOME/NuGetPackages"

# android / gradle
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export ANDROID_USER_HOME="$XDG_DATA_HOME/android"

# docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$DOTNET_CLI_HOME/.dotnet/tools"
export PATH="$PATH:$HOME/.aspire/bin"
export PATH="$PATH:$XDG_DATA_HOME/opencode/bin"

[[ -f $HOME/.zshenv.linux ]] && source $HOME/.zshenv.linux
[[ -f $HOME/.zshenv.macos ]] && source $HOME/.zshenv.macos
[[ -f $HOME/.zshenv.local ]] && source $HOME/.zshenv.local
