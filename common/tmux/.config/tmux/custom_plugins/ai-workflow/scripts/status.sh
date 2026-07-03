#!/opt/homebrew/bin/bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "$CURRENT_DIR/lib.sh"

"$CURRENT_DIR/sync-window-titles.sh" >/dev/null 2>&1

declare -A running_counts
declare -A active_counts
declare -A idle_counts
declare -A waiting_counts
declare -A emitted_providers

summary_output=""

while IFS="$(printf '\t')" read -r _rank _target _marker status _icon provider _label _location _row_title _command _title _path _message _source _updated_at _project _display_row; do
  case "$status" in
    waiting)
      waiting_counts["$provider"]=$(( ${waiting_counts["$provider"]:-0} + 1 ))
      ;;
    running)
      running_counts["$provider"]=$(( ${running_counts["$provider"]:-0} + 1 ))
      ;;
    active)
      active_counts["$provider"]=$(( ${active_counts["$provider"]:-0} + 1 ))
      ;;
    idle)
      idle_counts["$provider"]=$(( ${idle_counts["$provider"]:-0} + 1 ))
      ;;
  esac
done < <(ai_panes)

for priority_status in waiting running active idle; do
  for provider in opencode claude codex; do
    [ -z "${emitted_providers["$provider"]:-}" ] || continue
    case "$priority_status" in
      waiting) priority_count="${waiting_counts["$provider"]:-0}" ;;
      running) priority_count="${running_counts["$provider"]:-0}" ;;
      active) priority_count="${active_counts["$provider"]:-0}" ;;
      idle) priority_count="${idle_counts["$provider"]:-0}" ;;
    esac
    [ "$priority_count" -gt 0 ] || continue

    statuses=""
    for status in waiting running active idle; do
      case "$status" in
        waiting) count="${waiting_counts["$provider"]:-0}" ;;
        running) count="${running_counts["$provider"]:-0}" ;;
        active) count="${active_counts["$provider"]:-0}" ;;
        idle) count="${idle_counts["$provider"]:-0}" ;;
      esac

      [ "$count" -gt 0 ] || continue
      status_part="$(format_status_count "$status" "$count")"
      if [ -n "$statuses" ]; then
        statuses="$statuses, $status_part"
      else
        statuses="$status_part"
      fi
    done

    [ -n "$statuses" ] || continue
    item="$(provider_status_item "$provider" "$statuses")"
    emitted_providers["$provider"]=1

    if [ -n "$summary_output" ]; then
      summary_output="$summary_output  $item"
    else
      summary_output="$item"
    fi
  done
done

if [ -n "$summary_output" ]; then
  printf "%s " "$summary_output"
fi
