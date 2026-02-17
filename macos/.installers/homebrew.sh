#!/usr/bin/env bash

if command -v brew &>/dev/null; then
  echo "🍺 Homebrew is already installed"
else
  echo "🍺 Installing Homebrew..."

  # https://brew.sh
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
