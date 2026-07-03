#!/opt/homebrew/bin/bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASH_BIN="/opt/homebrew/bin/bash"
STATUS_COMMAND="#($BASH_BIN $CURRENT_DIR/scripts/status.sh)"
STATUS_INTERVAL="$(tmux show-option -gqv "@ai-workflow-status-interval")"
[ -n "$STATUS_INTERVAL" ] || STATUS_INTERVAL="3"

current_interval="$(tmux show-option -gqv status-interval)"
if [ -n "$STATUS_INTERVAL" ] && [ "$STATUS_INTERVAL" -gt 0 ] 2>/dev/null; then
  if [ -z "$current_interval" ] || [ "$current_interval" -eq 0 ] || [ "$current_interval" -gt "$STATUS_INTERVAL" ] 2>/dev/null; then
    tmux set-option -g status-interval "$STATUS_INTERVAL"
  fi
fi

current_status_right="$(tmux show-option -gqv status-right)"
case "$current_status_right" in
  *"custom_plugins/ai-workflow/scripts/status.sh"*) ;;
  *)
    tmux set-option -g status-right "$STATUS_COMMAND $current_status_right"
    ;;
esac

tmux bind-key y display-popup -E -w 90% -h 80% "$BASH_BIN $CURRENT_DIR/scripts/picker.sh"
