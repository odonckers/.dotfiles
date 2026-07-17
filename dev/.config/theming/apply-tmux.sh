#!/usr/bin/env sh
# Push the active theme's colors for a given mode (dark/light, default:
# current OS appearance) into a running tmux server and sync tmux-palette's
# popup theme to match. Safe to call with no tmux server running -- the
# tmux part is just skipped.
#
# Called once at tmux startup (tmux.conf) and again by the appearance
# watcher (see dev-macos/Library/LaunchAgents) whenever macOS's appearance
# changes, so an already-running session flips live like Ghostty does.
set -eu

DIR="$(cd "$(dirname "$0")" && pwd)"
. "$DIR/colors.sh"
. "$DIR/appearance.sh"
. "$DIR/fzf-opts.sh"

MODE="${1:-$(theming_mode)}"
theming_colors "$MODE"

if tmux info >/dev/null 2>&1; then
  tmux set-option -g status-style "fg=$THEME_TX_2,bg=$THEME_BG_2"
  tmux set-option -g message-style "fg=$THEME_TX,bg=$THEME_UI,fill=$THEME_UI"
  tmux set-option -g pane-scrollbars-style "fg=$THEME_YE,bg=default"

  tmux setw -g window-status-format "#[fg=$THEME_TX_2,bg=$THEME_UI] #I:#W "
  tmux setw -g window-status-current-format "#[fg=$THEME_BG,bg=$THEME_YE,bold] #I:#W "

  tmux set-option -g pane-border-style "fg=$THEME_UI_3,bg=default"
  tmux set-option -g pane-active-border-style "fg=$THEME_YE,bg=default"

  tmux set-option -g copy-mode-position-style "fg=$THEME_TX,bg=$THEME_UI"
  tmux set-option -g copy-mode-selection-style "fg=$THEME_BG,bg=$THEME_YE,bold"

  # For fzf invocations tmux spawns directly (tmux-fzf's C-s, the
  # popup-based `prefix + e` repo picker) -- both skip .zshrc, so they'd
  # otherwise never see a colored fzf until the server was restarted.
  tmux set-environment -g FZF_DEFAULT_OPTS "$(theming_fzf_opts)"
fi

# tmux-palette's own theme files follow "<theme>" (dark) / "<theme>-light"
# naming under .config/tmux-palette/themes/ -- drop a matching pair in
# there for any new theme added to theming/themes/.
THEME_NAME="$(theming_active_theme)"
PALETTE_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/tmux-palette"
mkdir -p "$PALETTE_DIR"
if [ "$MODE" = light ]; then
  printf '{\n  "name": "%s-light"\n}\n' "$THEME_NAME" > "$PALETTE_DIR/theme.json"
else
  printf '{\n  "name": "%s"\n}\n' "$THEME_NAME" > "$PALETTE_DIR/theme.json"
fi
