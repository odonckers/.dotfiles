#!/usr/bin/env bash

if command -v rustc &>/dev/null; then
  echo "🦀 Rust is already installed"
else
  echo "🦀 Installing Rust..."

  # https://rust-lang.org/tools/install
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
