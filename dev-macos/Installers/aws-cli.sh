#!/usr/bin/env bash

if command -v aws &>/dev/null; then
  echo "🚀 AWS CLI is already installed"
else
  echo "🚀 Installing AWS CLI..."

  curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
  sudo installer -pkg AWSCLIV2.pkg -target /
fi
