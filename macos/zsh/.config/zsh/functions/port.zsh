#!/usr/bin/env zsh

port() {
  if [ -z "$1" ]; then
      echo "Usage: port <port_number>"
      echo ""
      return 1
  fi

  lsof -i :$1
}
