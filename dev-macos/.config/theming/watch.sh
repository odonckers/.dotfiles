#!/usr/bin/env sh
# Poll macOS appearance every 2s and push tmux/tmux-palette updates on
# change. Runs under launchd (see ../../Library/LaunchAgents) so an
# already-open tmux session flips light/dark live, the same way Ghostty
# does natively. fzf/delta don't need this -- they recompute their colors
# themselves on every use.
set -eu

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/theming"
. "$CONFIG_DIR/appearance.sh"

last=""
while true; do
  mode="$(theming_mode)"
  if [ "$mode" != "$last" ]; then
    if "$CONFIG_DIR/apply-tmux.sh" "$mode"; then
      last="$mode"
    else
      echo "watch.sh: apply-tmux.sh failed for mode=$mode, will retry" >&2
    fi
  fi
  sleep 2
done
