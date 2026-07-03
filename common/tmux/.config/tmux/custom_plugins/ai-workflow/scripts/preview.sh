#!/opt/homebrew/bin/bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "$CURRENT_DIR/lib.sh"

line="$1"
[ -n "$line" ] || exit 0

IFS=$'\t' read -r _rank target marker status icon _provider label location row_title command title path message source updated_at project _display_row <<< "$line"
preview_lines="${FZF_PREVIEW_LINES:-${LINES:-40}}"
body_lines=$((preview_lines - 11))
[ -n "$title" ] && body_lines=$((body_lines - 1))
[ -n "$path" ] && body_lines=$((body_lines - 1))
[ -n "$message" ] && body_lines=$((body_lines - 1))
[ -n "$updated_at" ] && body_lines=$((body_lines - 1))
[ "$body_lines" -lt 8 ] && body_lines=8

printf "%s\n" "$row_title"
printf "Target:  %s\n" "$location"
printf "Project: %s\n" "$project"
printf "Command: %s\n" "$command"
[ -n "$title" ] && printf "Title:   %s\n" "$title"
[ -n "$path" ] && printf "Path:    %s\n" "$path"
printf "\n"
printf "Status:  %s %s %s\n" "$marker" "$status" "$icon $label"
[ -n "$message" ] && printf "Message: %s\n" "$message"
printf "Source:  %s\n" "$source"
[ -n "$updated_at" ] && printf "Updated: %s\n" "$updated_at"
printf "\n"
if [ "$(tmux display-message -p -t "$target" '#{alternate_on}' 2>/dev/null)" = "1" ]; then
  printf "Current fullscreen view\n"
else
  printf "Recent pane output\n"
fi
printf "%s\n" "-----------------------"
pane_preview_body "$target" "$body_lines"
