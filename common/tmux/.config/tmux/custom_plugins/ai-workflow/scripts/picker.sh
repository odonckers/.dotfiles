#!/opt/homebrew/bin/bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIST="$CURRENT_DIR/list.sh"

selected="$("$LIST" | fzf \
  --delimiter="$(printf '\t')" \
  --with-nth=20 \
  --nth=4,6,13,16,17,18,19,20 \
  --header="Select target agent." \
  --border \
  --bind="ctrl-r:reload($LIST)" \
  --prompt="ai> ")"

[ -n "$selected" ] || exit 0

IFS=$'\t' read -r _rank target _marker _status _icon _provider _label _location _row_title _command _title _path _message _source _updated_at _project _branch _worktree _diff_summary _display_row <<< "$selected"

tmux switch-client -t "$target" 2>/dev/null
tmux select-pane -t "$target" 2>/dev/null
