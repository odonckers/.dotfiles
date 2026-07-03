#!/opt/homebrew/bin/bash

provider_icon() {
  case "$1" in
    opencode) printf "◆" ;;
    claude) printf "✶" ;;
    codex) printf "⌘" ;;
    *) printf "•" ;;
  esac
}

provider_label() {
  case "$1" in
    opencode) printf "OpenCode" ;;
    claude) printf "Claude" ;;
    codex) printf "Codex" ;;
    *) printf "%s" "$1" ;;
  esac
}

state_dir() {
  printf "%s" "${TMUX_AI_WORKFLOW_STATE_DIR:-${XDG_STATE_HOME:-$HOME/.local/state}/tmux/ai-workflow}"
}

state_file() {
  pane_id="$1"
  safe_id="$(printf "%s" "$pane_id" | tr -c '[:alnum:]_.-' '_')"
  printf "%s/%s.tsv" "$(state_dir)" "$safe_id"
}

normalize_provider() {
  provider="$(printf "%s" "$1" | tr '[:upper:]' '[:lower:]')"

  case "$provider" in
    opencode|claude|codex) printf "%s" "$provider"; return 0 ;;
  esac

  return 1
}

normalize_status() {
  status="$(printf "%s" "$1" | tr '[:upper:]' '[:lower:]')"

  case "$status" in
    waiting|needs_input|needs-input|input|blocked)
      printf "waiting"
      return 0
      ;;
    running|working|thinking|busy|in_progress|in-progress)
      printf "running"
      return 0
      ;;
    idle|ready|done|complete|completed|finished)
      printf "idle"
      return 0
      ;;
    active)
      printf "active"
      return 0
      ;;
  esac

  return 1
}

provider_from_command() {
  command="$(basename "$1" | tr '[:upper:]' '[:lower:]')"

  case "$command" in
    opencode) printf "opencode"; return 0 ;;
    claude) printf "claude"; return 0 ;;
    codex|codex-*) printf "codex"; return 0 ;;
  esac

  return 1
}

status_icon() {
  case "$1" in
    waiting) printf "◈" ;;
    running) printf "●" ;;
    active) printf "◐" ;;
    idle) printf "○" ;;
    *) printf "•" ;;
  esac
}

status_rank() {
  case "$1" in
    waiting) printf "0" ;;
    running) printf "1" ;;
    active) printf "2" ;;
    idle) printf "3" ;;
    *) printf "3" ;;
  esac
}

status_word() {
  case "$1" in
    waiting) printf "waiting" ;;
    running) printf "working" ;;
    active) printf "active" ;;
    idle) printf "ready" ;;
    *) printf "agent" ;;
  esac
}

status_item() {
  provider="$1"
  status="$2"
  count="${3:-1}"
  icon="$(provider_icon "$provider")"
  word="$(status_word "$status")"
  item="$icon $provider [$word"
  [ "$count" -gt 1 ] 2>/dev/null && item="$item $count"
  item="$item]"
  printf "%s" "$item"
}

provider_status_item() {
  provider="$1"
  statuses="$2"
  icon="$(provider_icon "$provider")"
  printf "%s %s [%s]" "$icon" "$provider" "$statuses"
}

format_status_count() {
  status="$1"
  count="${2:-1}"
  word="$(status_word "$status")"
  if [ "$count" -gt 1 ] 2>/dev/null; then
    printf "%s %s" "$word" "$count"
  else
    printf "%s" "$word"
  fi
}

project_name() {
  path="$1"
  if [ -n "$path" ]; then
    basename "$path"
  else
    printf "-"
  fi
}

picker_row() {
  status="$1"
  project="$2"
  branch="$3"
  worktree="$4"
  diff_summary="$5"
  icon="$6"
  provider="$7"
  marker="$(status_icon "$status")"
  name="$icon $provider"

  printf "%-10s  %-20s  %-16s  %-12s  %-18s  %-12s" \
    "$marker $(status_word "$status")" \
    "$(truncate "$project" 20)" \
    "$(truncate "${branch:-no-branch}" 16)" \
    "$(truncate "${worktree:-}" 12)" \
    "$(truncate "${diff_summary:-clean}" 18)" \
    "$name"
}

git_branch() {
  path="$1"
  [ -n "$path" ] || return 1
  git -C "$path" rev-parse --is-inside-work-tree >/dev/null 2>&1 || return 1

  branch="$(git -C "$path" branch --show-current 2>/dev/null)"
  if [ -z "$branch" ]; then
    branch="$(git -C "$path" rev-parse --short HEAD 2>/dev/null)"
  fi

  [ -n "$branch" ] || return 1
  printf "%s" "$branch"
}

git_worktree_name() {
  path="$1"
  [ -n "$path" ] || return 1
  git -C "$path" rev-parse --is-inside-work-tree >/dev/null 2>&1 || return 1

  git_dir="$(git -C "$path" rev-parse --absolute-git-dir 2>/dev/null)"
  case "$git_dir" in
    */.git/worktrees/*)
      printf "%s" "$(basename "$git_dir")"
      return 0
      ;;
  esac

  return 1
}

git_diff_summary() {
  path="$1"
  [ -n "$path" ] || return 1
  git -C "$path" rev-parse --is-inside-work-tree >/dev/null 2>&1 || return 1

  shortstat="$(
    git -C "$path" diff --shortstat HEAD -- 2>/dev/null |
    awk -F ',' '
      {
        for (i = 1; i <= NF; i++) {
          gsub(/^ +| +$/, "", $i)
          if ($i ~ /files? changed/) {
            split($i, files, " ")
          } else if ($i ~ /insertions?/) {
            split($i, insertions, " ")
          } else if ($i ~ /deletions?/) {
            split($i, deletions, " ")
          }
        }
      }
      END {
        if (files[1] != "") {
          printf "%sf", files[1]
        }
        if (insertions[1] != "") {
          printf "%s+%s", (files[1] != "" ? " " : ""), insertions[1]
        }
        if (deletions[1] != "") {
          printf "%s-%s", (files[1] != "" || insertions[1] != "" ? " " : ""), deletions[1]
        }
      }
    '
  )"

  untracked="$(
    git -C "$path" status --porcelain 2>/dev/null |
    awk 'substr($0, 1, 2) == "??" { count++ } END { if (count > 0) print count }'
  )"

  if [ -n "$shortstat" ]; then
    if [ -n "$untracked" ]; then
      printf "%s ?%s" "$shortstat" "$untracked"
    else
      printf "%s" "$shortstat"
    fi
    return 0
  fi

  status_summary="$(
    git -C "$path" status --porcelain 2>/dev/null |
    awk '
      {
        x = substr($0, 1, 1)
        y = substr($0, 2, 1)
        if (x == "?" && y == "?") { untracked++; next }
        if (x == "!" && y == "!") { next }
        if (x == "A" || y == "A") { added++ }
        if (x == "M" || y == "M") { modified++ }
        if (x == "D" || y == "D") { deleted++ }
        if (x == "R" || y == "R") { renamed++ }
        if (x == "C" || y == "C") { copied++ }
        if (x == "U" || y == "U" || x == "A" && y == "A" || x == "D" && y == "D") { conflicted++ }
      }
      END {
        if (added) { printf "%s+%d", sep, added; sep = " " }
        if (modified) { printf "%s~%d", sep, modified; sep = " " }
        if (deleted) { printf "%s-%d", sep, deleted; sep = " " }
        if (renamed) { printf "%sr%d", sep, renamed; sep = " " }
        if (copied) { printf "%sc%d", sep, copied; sep = " " }
        if (untracked) { printf "%s?%d", sep, untracked; sep = " " }
        if (conflicted) { printf "%s!%d", sep, conflicted; sep = " " }
      }
    '
  )"

  if [ -n "$status_summary" ]; then
    printf "%s" "$status_summary"
  else
    printf "clean"
  fi
}

truncate() {
  text="$1"
  max="$2"

  if [ "${#text}" -le "$max" ]; then
    printf "%s" "$text"
    return 0
  fi

  printf "%s…" "${text:0:$((max - 1))}"
}

pane_snapshot() {
  target="$1"
  tmux capture-pane -epJ -S -80 -t "$target" 2>/dev/null
}

pane_fingerprint() {
  target="$1"
  alternate_on="$(tmux display-message -p -t "$target" '#{alternate_on}' 2>/dev/null)"

  if [ "$alternate_on" = "1" ]; then
    body="$(tmux capture-pane -apJ -S 0 -E - -t "$target" 2>/dev/null)"
    if ! printf "%s\n" "$body" | grep -q '[^[:space:]]'; then
      body="$(tmux capture-pane -pJ -S 0 -E - -t "$target" 2>/dev/null)"
    fi

    printf "%s" "$body" | cksum | awk '{ printf "%s:%s", $1, $2 }'
  else
    pane_snapshot "$target" | cksum | awk '{ printf "%s:%s", $1, $2 }'
  fi
}

pane_preview_body() {
  target="$1"
  max_lines="${2:-40}"
  alternate_on="$(tmux display-message -p -t "$target" '#{alternate_on}' 2>/dev/null)"

  if [ "$alternate_on" = "1" ]; then
    body="$(tmux capture-pane -apq -S 0 -E - -t "$target" 2>/dev/null)"
    if ! printf "%s\n" "$body" | grep -q '[^[:space:]]'; then
      body="$(tmux capture-pane -pq -S 0 -E - -t "$target" 2>/dev/null)"
    fi

    printf "%s\n" "$body" | sed -n "1,${max_lines}p"
  else
    tmux capture-pane -p -S "-$max_lines" -E - -t "$target" 2>/dev/null | tail -n "$max_lines"
  fi
}

refresh_status() {
  [ -n "$(tmux list-clients -F '#{client_tty}' 2>/dev/null)" ] || return 0
  tmux refresh-client -S >/dev/null 2>&1 || true
}

pane_state() {
  pane_id="$1"
  file="$(state_file "$pane_id")"
  [ -f "$file" ] || return 1

  IFS=$'\t' read -r provider status message updated_at updated_epoch fingerprint < "$file" || return 1
  provider="$(normalize_provider "$provider")" || return 1
  status="$(normalize_status "$status")" || return 1
  printf "%s\t%s\t%s\t%s\t%s\t%s\n" "$provider" "$status" "$message" "$updated_at" "$updated_epoch" "$fingerprint"
}

resolved_pane_state() {
  pane_id="$1"
  command="$2"

  state="$(pane_state "$pane_id")"
  if [ -n "$state" ]; then
    IFS=$'\t' read -r provider status message updated_at updated_epoch fingerprint <<< "$state"
    detected_provider="$(provider_from_command "$command" 2>/dev/null || true)"

    if [ "$status" = "waiting" ] && [ "$detected_provider" = "$provider" ]; then
      current_fingerprint="$(pane_fingerprint "$pane_id")"
      if [ -z "$fingerprint" ] || { [ -n "$current_fingerprint" ] && [ "$current_fingerprint" != "$fingerprint" ]; }; then
        status="running"
        message="working"
      fi
    fi

    printf "%s\t%s\t%s\t%s\t%s\t%s\n" "$provider" "$status" "$message" "$updated_at" "$updated_epoch" "$fingerprint"
    return 0
  fi

  provider="$(provider_from_command "$command")" || return 1
  printf "%s\tidle\t\t\t\t\n" "$provider"
}

window_agent_rows() {
  window_target="$1"

  tmux list-panes -t "$window_target" -F "#{pane_id}	#{pane_current_command}" 2>/dev/null |
  while IFS="$(printf '\t')" read -r pane_id command; do
    state="$(resolved_pane_state "$pane_id" "$command")" || continue
    IFS=$'\t' read -r provider status message _updated_at _updated_epoch _fingerprint <<< "$state"

    rank="$(status_rank "$status")"
    icon="$(provider_icon "$provider")"
    printf "%s\t%s\t%s\t%s\t%s\n" "$rank" "$status" "$provider" "$icon" "$message"
  done
}

best_window_agent_row() {
  window_target="$1"
  window_agent_rows "$window_target" |
  sort -t "$(printf '\t')" -k1,1n -k3,3 -k2,2 |
  awk -F '\t' '
    NR == 1 {
      rank = $1
      status = $2
      provider = $3
      icon = $4
      count = 1
      next
    }
    $1 == rank && $2 == status && $3 == provider {
      count++
    }
    END {
      if (NR > 0) {
        printf "%s\t%s\t%s\t%s\t%s\n", rank, status, provider, icon, count
      }
    }
  '
}

window_status_item() {
  window_target="$1"
  rows="$(window_agent_rows "$window_target")"
  [ -n "$rows" ] || return 1

  provider="$(printf "%s\n" "$rows" | sort -t "$(printf '\t')" -k1,1n -k3,3 -k2,2 | awk -F '\t' 'NR == 1 { print $3; exit }')"
  [ -n "$provider" ] || return 1

  status_counts="$(
    printf "%s\n" "$rows" |
    awk -F '\t' -v provider="$provider" '$3 == provider { counts[$2]++ } END {
      order[1] = "waiting"
      order[2] = "running"
      order[3] = "active"
      order[4] = "idle"
      for (i = 1; i <= 4; i++) {
        status = order[i]
        if (counts[status] > 0) {
          printf "%s\t%s\n", status, counts[status]
        }
      }
    }'
  )"
  [ -n "$status_counts" ] || return 1

  formatted=""
  while IFS="$(printf '\t')" read -r status count; do
    item="$(format_status_count "$status" "${count:-1}")"
    if [ -n "$formatted" ]; then
      formatted="$formatted, $item"
    else
      formatted="$item"
    fi
  done <<< "$status_counts"

  provider_status_item "$provider" "$formatted"
}

sync_window_title() {
  pane_target="$1"
  window_id="$(tmux display-message -p -t "$pane_target" '#{window_id}' 2>/dev/null)"
  [ -n "$window_id" ] || return 0

  item="$(window_status_item "$window_id")"
  base_name="$(tmux show-option -wqv -t "$window_id" '@ai_workflow_base_name' 2>/dev/null)"
  current_name="$(tmux display-message -p -t "$window_id" '#{window_name}' 2>/dev/null)"

  if [ -z "$item" ]; then
    if [ -n "$base_name" ]; then
      tmux rename-window -t "$window_id" "$base_name" 2>/dev/null || true
      tmux set-option -wuq -t "$window_id" '@ai_workflow_base_name' 2>/dev/null || true
    fi
    return 0
  fi

  if [ -z "$base_name" ]; then
    base_name="$current_name"
    tmux set-option -wq -t "$window_id" '@ai_workflow_base_name' "$base_name" 2>/dev/null || true
  fi

  tmux rename-window -t "$window_id" "$item" 2>/dev/null || true
}

ai_panes() {
  tmux list-panes -a -F "#{pane_id}	#{session_name}	#{window_index}	#{window_name}	#{pane_index}	#{pane_current_command}	#{pane_title}	#{pane_current_path}" |
  while IFS="$(printf '\t')" read -r pane_id session window_index window pane_index command title path; do
    state="$(resolved_pane_state "$pane_id" "$command")" || continue
    IFS=$'\t' read -r provider status message updated_at _updated_epoch _fingerprint <<< "$state"

    state_file_path="$(state_file "$pane_id")"
    if [ -f "$state_file_path" ]; then
      source="hook"
    else
      source="auto"
    fi

    icon="$(provider_icon "$provider")"
    label="$(provider_label "$provider")"
    marker="$(status_icon "$status")"
    rank="$(status_rank "$status")"
    target="$session:$window_index.$pane_index"
    location="$session:$window_index.$pane_index"
    project="$(project_name "$path")"
    branch="$(git_branch "$path" 2>/dev/null || true)"
    worktree="$(git_worktree_name "$path" 2>/dev/null || true)"
    diff_summary="$(git_diff_summary "$path" 2>/dev/null || true)"
    display_row="$(picker_row "$status" "$project" "$branch" "$worktree" "$diff_summary" "$icon" "$provider")"
    display_message="$(truncate "$message" 48)"
    if [ -n "$display_message" ]; then
      row_title="$marker $status · $session · $icon $label · $display_message"
    else
      row_title="$marker $status · $session · $icon $label"
    fi

    printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n" \
      "$rank" "$target" "$marker" "$status" "$icon" "$provider" "$label" "$location" "$row_title" "$command" "$title" "$path" "$message" "$source" "$updated_at" "$project" "$branch" "$worktree" "$diff_summary" "$display_row"
  done
}
