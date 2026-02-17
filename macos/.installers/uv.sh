#!/usr/bin/env bash

if command -v uv &>/dev/null; then
  echo "🐍 UV is already installed"
else
  echo "🐍 Installing UV..."

  # Install UV
  curl -LsSf https://astral.sh/uv/install.sh | sh
fi
