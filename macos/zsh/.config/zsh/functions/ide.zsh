#!/usr/bin/env zsh

ide() {
  SESSION_NAME=$1
  if [ -z "$SESSION_NAME" ]; then
      echo "Usage: ide <zoxide_directory>"
      echo ""
      return 1
  fi

  TARGET_DIR=$(zoxide query $SESSION_NAME)
  if [ -z "$TARGET_DIR" ]; then
      echo "Error: Directory '$SESSION_NAME' not found in zoxide."
      echo ""
      return 1
  fi

  # Create a new detached session and name the first window 'nvim'
  tmux new-session -d -s "$SESSION_NAME" -n 'nvim' -c "$TARGET_DIR" "nvim; zsh"

  # Create the remaining windows with specific names
  tmux new-window -t "$SESSION_NAME" -n 'opencode' -c "$TARGET_DIR" "opencode; zsh"
  tmux new-window -t "$SESSION_NAME" -n 'lazygit'  -c "$TARGET_DIR" "lazygit; zsh"
  tmux new-window -t "$SESSION_NAME" -n 'console'  -c "$TARGET_DIR"

  # Select the first window (vim) so you land there upon attaching
  tmux select-window -t "$SESSION_NAME:1"
}
