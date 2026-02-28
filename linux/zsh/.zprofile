#!/usr/bin/env zsh

if (( $+commands[sway] )); then
  # Auto-launch Sway on TTY1 login
  if [ "$(tty)" = "/dev/tty1" ]; then
      read -p "Start Sway? [y]es or [n]o: " -n 1 -r
      echo
      if [[ $REPLY =~ ^[Yy]$ ]]; then
          exec sway
      fi
  fi
fi
