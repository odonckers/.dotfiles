#!/usr/bin/env bash

# Reset directory to origin or clone
NETCOREDBG_DIR=$XDG_DATA_HOME/netcoredbg
if [ -d $NETCOREDBG_DIR ]; then
  cd $NETCOREDBG_DIR
  git reset --hard origin/master
  git clean -xdf
else
  git clone git@github.com:Samsung/netcoredbg.git $NETCOREDBG_DIR
  cd $NETCOREDBG_DIR
fi

# Build the project
mkdir -p build
cd build/
CC=clang CXX=clang++ cmake .. -DCMAKE_INSTALL_PREFIX=$PWD/../bin
make
make install
