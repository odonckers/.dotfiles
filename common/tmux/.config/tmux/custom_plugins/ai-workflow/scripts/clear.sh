#!/opt/homebrew/bin/bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "$CURRENT_DIR/lib.sh"

pane_id="${TMUX_PANE:-}"
if [ -z "$pane_id" ]; then
  pane_id="$(tmux display-message -p '#{pane_id}' 2>/dev/null)"
fi

[ -n "$pane_id" ] || exit 0

rm -f "$(state_file "$pane_id")"
sync_window_title "$pane_id"
refresh_status
