#!/opt/homebrew/bin/bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "$CURRENT_DIR/lib.sh"

usage() {
  printf "usage: %s <opencode|claude|codex> <waiting|running|idle|active> [message]\n" "$0" >&2
}

provider="$(normalize_provider "${1:-}")" || {
  usage
  exit 2
}

status="$(normalize_status "${2:-}")" || {
  usage
  exit 2
}

shift 2
message="$*"
message="${message//$'\t'/ }"
message="${message//$'\n'/ }"

pane_id="${TMUX_PANE:-}"
if [ -z "$pane_id" ]; then
  pane_id="$(tmux display-message -p '#{pane_id}' 2>/dev/null)"
fi

if [ -z "$pane_id" ]; then
  printf "ai-workflow: cannot determine tmux pane id\n" >&2
  exit 1
fi

dir="$(state_dir)"
mkdir -p "$dir"

updated_at="$(date '+%Y-%m-%d %H:%M:%S')"
updated_epoch="$(date '+%s')"
fingerprint="$(pane_fingerprint "$pane_id")"
printf "%s\t%s\t%s\t%s\t%s\t%s\n" "$provider" "$status" "$message" "$updated_at" "$updated_epoch" "$fingerprint" > "$(state_file "$pane_id")"
sync_window_title "$pane_id"
refresh_status
