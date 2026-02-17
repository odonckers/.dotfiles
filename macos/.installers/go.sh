#!/usr/bin/env bash

if command -v go &>/dev/null; then
  echo "🐿️ Go is already installed"
else
  echo "🐿️ Install Go from opened website in your browser"

  open https://go.dev/dl
fi
