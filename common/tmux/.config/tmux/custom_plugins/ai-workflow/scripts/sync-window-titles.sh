#!/opt/homebrew/bin/bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "$CURRENT_DIR/lib.sh"

tmux list-windows -a -F "#{window_id}" 2>/dev/null |
while IFS= read -r window_id; do
  [ -n "$window_id" ] || continue
  sync_window_title "$window_id"
done
