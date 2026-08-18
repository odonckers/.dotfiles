#!/usr/bin/env zsh

# Claude Code account handling.
#
# Plain `claude` follows ~/.claude, the same profile selected for Claude
# Desktop. `claude-personal` and `claude-bethel` are explicit one-off overrides
# that do not change the desktop selection.
#
# Claude Desktop writes its own Claude Code sessions under ~/.claude and has no
# way to be told otherwise. The macOS package's claude-desktop.zsh symlinks it
# alongside the app's data dir, reusing the helpers below.

# Yes/no prompt defaulting to no. read -q talks to the terminal rather than
# stdin, so a non-interactive caller can't answer -- it fails, which lands on
# the same "no" the empty answer would, and nothing destructive proceeds.
_claude_confirm() {
  local reply
  read -q "reply?$1 [y/N] "
  print
  [[ "$reply" == [yY] ]]
}

# Prompts for one of "personal" / "bethel". $1 is a symlink whose target is
# marked "(current)" in the menu -- omit it where nothing is linked and there
# is no current profile to speak of. $2 skips the prompt entirely, giving
# callers a non-interactive form for free.
_claude_pick_profile() {
  local link="$1" preset="$2"

  if [[ -n "$preset" ]]; then
    case "$preset" in
      personal|bethel) print "$preset"; return 0 ;;
      *) print -u2 "claude: unknown profile '$preset' (expected personal or bethel)"; return 1 ;;
    esac
  fi

  # readlink is only meaningful on a symlink; anything else has no current profile
  local current=""
  [[ -L "$link" ]] && current="${$(readlink "$link"):t}"

  local choice
  choice=$(
    for profile in personal bethel; do
      # Match against the tail of the link target so this works for both
      # ~/.claude -> .claude-personal and .../Claude -> Claude-Personal
      if [[ -n "$current" && "${current:l}" == *"$profile" ]]; then
        print "$profile (current)"
      else
        print "$profile"
      fi
    done | fzf --prompt="Select Claude profile > " --height=~10 --layout=reverse
  )

  [[ -z "$choice" ]] && { print -u2 "claude: no selection made"; return 1 }
  print "${choice%% *}"
}

# Points $1 (the default path) at $2, a profile directory sitting beside it.
# A pre-existing real directory is moved aside rather than removed, so no state
# is ever destroyed -- only a symlink is unlinked.
_claude_link_profile() {
  local link="$1" profile="$2"
  local parent="${link:h}"

  [[ -d "$parent/$profile" ]] || {
    print -u2 "claude: $parent/$profile does not exist"
    return 1
  }

  if [[ -L "$link" ]]; then
    rm "$link" || return 1
  elif [[ -e "$link" ]]; then
    local backup="$link.bak-$(date +%Y%m%d%H%M%S)"
    mv "$link" "$backup" || return 1
    print "claude: moved existing $link to $backup"
  fi

  # Relative target -- resolves inside $parent, so the link survives the whole
  # tree being moved (and reads cleanly in `ls -l`)
  ln -s "$profile" "$link" || return 1
  print "claude: $link -> $profile"
}

if (( $+commands[claude] )); then
  # Keep the three entry points consistent and forward every argument unchanged.
  _claude_run_profile() {
    local config_dir="$1"
    shift
    CLAUDE_CONFIG_DIR="$config_dir" command claude "$@"
  }

  claude() {
    _claude_run_profile "$HOME/.claude" "$@"
  }

  claude-personal() {
    _claude_run_profile "$HOME/.claude-personal" "$@"
  }

  claude-bethel() {
    _claude_run_profile "$HOME/.claude-bethel" "$@"
  }
fi
