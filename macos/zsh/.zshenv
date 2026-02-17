#!/usr/bin/env zsh

eval "$(/opt/homebrew/bin/brew shellenv)"

export XDG_CONFIG_HOME="$HOME/.config" && mkdir -p $XDG_CONFIG_HOME
export XDG_DATA_HOME="$HOME/.local/share" && mkdir -p $XDG_DATA_HOME
export XDG_STATE_HOME="$HOME/.local/state" && mkdir -p $XDG_STATE_HOME
export XDG_CACHE_HOME="$HOME/.cache" && mkdir -p $XDG_CACHE_HOME
export XDG_RUNTIME_DIR="$HOME/.local/run/$UID" && mkdir -p $XDG_RUNTIME_DIR

mkdir -p "$XDG_STATE_HOME/zsh"
export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
export HISTFILE="$XDG_STATE_HOME/zsh/history"

# For compilers to find llvm
export LDFLAGS="-L$HOMEBREW_PREFIX/opt/llvm/lib"
export CPPFLAGS="-I$HOMEBREW_PREFIX/opt/llvm/include"

# For cmake to find llvm
export CMAKE_PREFIX_PATH="$HOMEBREW_PREFIX/opt/llvm"

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

export PATH="$HOMEBREW_PREFIX/bin:$PATH"
export PATH="$PATH:$HOMEBREW_PREFIX/opt/llvm/bin"
export PATH="$PATH:$HOMEBREW_PREFIX/opt/ccache/libexec"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$DOTNET_CLI_HOME/.dotnet/tools"
export PATH="$PATH:$HOME/.aspire/bin"
export PATH="$PATH:$XDG_DATA_HOME/opencode/bin"
export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"
export PATH="$PATH:$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
export PATH="$PATH:/Applications/MySQLWorkbench.app/Contents/MacOS"

[[ -f $XDG_CONFIG_HOME/zsh/zshenv.local ]] && source $XDG_CONFIG_HOME/zsh/zshenv.local
