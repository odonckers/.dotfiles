#!/opt/homebrew/bin/bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPORT="$CURRENT_DIR/../scripts/report.sh"

provider="${1:-}"
event="${2:-}"
shift 2 2>/dev/null || true
message="$*"

event_lc="$(printf "%s" "$event" | tr '[:upper:]' '[:lower:]')"

case "$event_lc" in
  notification)
    if [ "$provider" = "claude" ]; then
      status="idle"
      message=""
    else
      status="waiting"
      [ -n "$message" ] || message="needs attention"
    fi
    ;;
  permissionrequest|permission-request|permission|notification|input|waiting|needs_input|needs-input)
    status="waiting"
    [ -n "$message" ] || message="needs attention"
    ;;
  userpromptsubmit|user-prompt-submit|pretooluse|pre-tool-use|posttooluse|post-tool-use|subagentstart|subagent-start|running|working)
    status="running"
    [ -n "$message" ] || message="working"
    ;;
  stop|subagentstop|subagent-stop|sessionstart|session-start|idle|ready|complete|completed)
    status="idle"
    ;;
  active)
    status="active"
    ;;
  *)
    status="active"
    [ -n "$message" ] || message="$event"
    ;;
esac

exec "$REPORT" "$provider" "$status" "$message"
