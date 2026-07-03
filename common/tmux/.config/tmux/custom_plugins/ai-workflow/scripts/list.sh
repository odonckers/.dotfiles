#!/opt/homebrew/bin/bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "$CURRENT_DIR/lib.sh"

ai_panes | sort -t "$(printf '\t')" -k1,1n -k16,16 -k17,17 -k6,6
