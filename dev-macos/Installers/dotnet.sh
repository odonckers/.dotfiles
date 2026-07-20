#!/usr/bin/env bash

if command -v dotnet &>/dev/null; then
  echo "🔵 .NET is already installed"
else
  echo "🔵 Install .NET from opened website in your browser"

  open https://dotnet.microsoft.com/en-us/download
fi
