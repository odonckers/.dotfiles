#!/opt/homebrew/bin/bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec "$CURRENT_DIR/agent-event.sh" opencode "$@"
