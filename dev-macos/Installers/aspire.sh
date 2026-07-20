#!/usr/bin/env bash

if command -v aspire &>/dev/null; then
  echo "🟪 Aspire is already installed"
else
  echo "🟪 Installing Aspire..."

  # https://aspire.dev/get-started/install-cli/#install-the-aspire-cli
  curl -sSL https://aspire.dev/install.sh | bash
fi
