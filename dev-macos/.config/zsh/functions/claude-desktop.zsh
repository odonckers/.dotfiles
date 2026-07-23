#!/usr/bin/env zsh

# Claude Desktop profile switching, reusing the helpers from dev's
# functions/claude.zsh. macOS only -- the user data dir lives under
# ~/Library/Application Support, which has no Linux equivalent.
#
# Unlike the CLI, the app has no per-invocation way to be told which account to
# use: it reads a fixed path at launch. So switching means pointing that path
# at the wanted profile, which is also what makes Dock and Spotlight launches
# land on the right account (--user-data-dir only ever covered shell launches).
#
# Two paths move together, because the app uses both: its own data dir, and
# ~/.claude, where the Claude Code sessions it runs are stored.

# -x so this matches the app process itself and not its "Claude Helper"
# children, which would otherwise keep the wait loop spinning forever.
_claude_desktop_running() { pgrep -x Claude >/dev/null 2>&1 }

# Asks the app to quit the way ⌘Q does, so it flushes state instead of losing
# it, then waits for the process to actually go away -- relinking underneath a
# still-running app would have it write into the old profile until it exits.
_claude_desktop_quit() {
  print "claude: quitting Claude Desktop..."
  osascript -e 'tell application "Claude" to quit' >/dev/null 2>&1

  local waited=0
  while _claude_desktop_running; do
    # 15s: generous for a normal quit, but bounded so an unsaved-changes dialog
    # or a hung window leaves the link untouched rather than half-switched
    if (( waited >= 150 )); then
      print -u2 "claude: Claude Desktop did not quit -- close it manually and re-run"
      return 1
    fi
    sleep 0.1
    (( waited++ ))
  done
}

claude-set-desktop-profile() {
  local support="$HOME/Library/Application Support"

  # Picked before anything is quit, so backing out of the picker costs nothing
  local choice
  choice=$(_claude_pick_profile "$support/Claude" "$1") || return 1

  # (C) title-cases each word: personal -> Personal, matching Claude-Personal
  local app_profile="Claude-${(C)choice}" cli_profile=".claude-$choice"

  # Both targets are checked up front: finding one missing after the app has
  # already been quit and one link moved would leave the two out of sync
  local missing
  for missing in "$support/$app_profile" "$HOME/$cli_profile"; do
    [[ -d "$missing" ]] || { print -u2 "claude: $missing does not exist"; return 1 }
  done

  # The data dir is read at launch, so a running app has to be cycled for the
  # new profile to take effect. Only worth interrupting the user when it is
  # actually open -- and only worth reopening if it was open to begin with.
  local was_running=0
  if _claude_desktop_running; then
    _claude_confirm "claude: Claude Desktop is open and must be restarted to switch to $choice. Quit and reopen it?" ||
      { print "claude: aborted, nothing changed"; return 1 }

    was_running=1
    _claude_desktop_quit || return 1
  fi

  _claude_link_profile "$support/Claude" "$app_profile" || return 1
  _claude_link_profile "$HOME/.claude" "$cli_profile" || return 1

  # No --user-data-dir: the whole point is that it now follows the symlink
  if (( was_running )); then
    print "claude: reopening Claude Desktop..."
    open -a "Claude"
  fi
}

# Launch a specific profile without touching the symlink -- one-off access to
# the other account while the linked one stays put.
alias open-claude-desktop-personal='open -n -a "Claude" --args --user-data-dir="$HOME/Library/Application Support/Claude-Personal"'
alias open-claude-desktop-bethel='open -n -a "Claude" --args --user-data-dir="$HOME/Library/Application Support/Claude-Bethel"'
