#!/usr/bin/env bash

if command -v omz &>/dev/null; then
  echo "✨ Oh-My-ZSH is already installed"
else
  echo "✨ Installing Oh-My-ZSH..."

  # https://ohmyz.sh/#install
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
