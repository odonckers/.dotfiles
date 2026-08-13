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
  tmux set-option -g pane-scrollbars-style "fg=$THEME_ACCENT,bg=default"

  tmux setw -g window-status-format "#[fg=$THEME_TX_2,bg=$THEME_UI] #I:#W#{?window_zoomed_flag, 󰘖,} "
  tmux setw -g window-status-current-format "#[fg=$THEME_BG,bg=$THEME_ACCENT,bold] #I:#W#{?window_zoomed_flag, 󰘖,} "

  tmux set-option -g pane-border-style "fg=$THEME_UI_3,bg=default"
  tmux set-option -g pane-active-border-style "fg=$THEME_ACCENT,bg=default"

  tmux set-option -g copy-mode-position-style "fg=$THEME_TX,bg=$THEME_UI"
  tmux set-option -g copy-mode-selection-style "fg=$THEME_BG,bg=$THEME_ACCENT,bold"

  # The choosers (`prefix s` / `prefix w` choose-tree) and the pane
  # display-menu default to a literal ANSI yellow highlight, which ignores
  # the palette entirely -- theme them explicitly.
  tmux set-option -g mode-style "fg=$THEME_BG,bg=$THEME_ACCENT,bold"
  tmux set-option -g menu-style "fg=$THEME_TX,bg=$THEME_UI"
  tmux set-option -g menu-selected-style "fg=$THEME_BG,bg=$THEME_ACCENT,bold"
  tmux set-option -g menu-border-style "fg=$THEME_UI_3"
  tmux set-option -g message-command-style "fg=$THEME_TX,bg=$THEME_UI"

  # For fzf invocations tmux spawns directly (tmux-fzf's C-s, the
  # popup-based `prefix + e` repo picker) -- both skip .zshrc, so they'd
  # otherwise never see a colored fzf until the server was restarted.
  tmux set-environment -g FZF_DEFAULT_OPTS "$(theming_fzf_opts)"
fi

# tmux-palette keeps its tiny selection file, but the selected native theme
# name comes from the same central appearance config as every other target.
THEME_NAME="$(dots_appearance_target tmuxPalette "$MODE")"
GENERATED_DIR="$DOTFILES_CONFIG_DIR/generated"
mkdir -p "$GENERATED_DIR"
TEMPORARY="$(mktemp "$GENERATED_DIR/.tmux-palette.XXXXXX")"
if printf '{\n  "name": "%s"\n}\n' "$THEME_NAME" >"$TEMPORARY"; then
  chmod 0644 "$TEMPORARY"
  mv -f "$TEMPORARY" "$GENERATED_DIR/tmux-palette-theme.json"
else
  rm -f "$TEMPORARY"
  exit 1
fi
