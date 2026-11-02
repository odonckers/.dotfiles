#!/usr/bin/env bash

set -euo pipefail

# Reset directory to origin or clone
NETCOREDBG_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/netcoredbg"
if [ -d "$NETCOREDBG_DIR/.git" ]; then
  cd "$NETCOREDBG_DIR"
  git fetch origin
  git reset --hard origin/master
  git clean -xdf
else
  git clone git@github.com:Samsung/netcoredbg.git "$NETCOREDBG_DIR"
  cd "$NETCOREDBG_DIR"
fi

# Build the project
mkdir -p build
cd build/
CC=clang CXX=clang++ cmake .. -DCMAKE_INSTALL_PREFIX=$PWD/../bin
make
make install
