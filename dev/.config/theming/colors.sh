#!/usr/bin/env sh
# Theme-agnostic color loader, shared by every tool that can't do its own
# light/dark switching (tmux, fzf, delta). Ghostty has both palettes built
# in and switches itself; Neovim picks up `background` from the terminal
# automatically -- neither needs this.
#
# Drop a new theme in by adding themes/<name>.sh with a theme_colors()
# function that sets THEME_{BG,BG_2,UI,UI_2,UI_3,TX_3,TX_2,TX,RE_2,GR_2,YE,
# YE_2,CY_2} for "dark" and "light" (see themes/flexoki.sh). Token names
# follow Flexoki's own convention (https://stephango.com/flexoki) rather
# than naming colors literally, so a theme with a different hue for, say,
# its primary accent still slots into the same role:
#   bg / bg-2        base background / a step up (status bar, fzf bg+)
#   ui / ui-2 / ui-3 panel backgrounds and unfocused borders, low to high
#   tx / tx-2 / tx-3 primary / muted / faint foreground text
#   re-2              borders, removed-line markers (Flexoki: red)
#   gr-2              added-line markers (Flexoki: green)
#   ye                primary accent -- active pane border, current tab
#                      (Flexoki: yellow)
#   ye-2              secondary accent -- fzf pointer/prompt (Flexoki: yellow)
#   cy-2              info/spinner accents (Flexoki: cyan)
# The "-2" tier is the counterpart tier from Flexoki's 12-tone accent scale
# (see themes/flexoki.sh) -- tx-3 is unused today but reserved for a future
# faint-text role.
#
# Ghostty is NOT wired into this: its `theme = dark:X, light:Y` in
# dev/.config/ghostty/config only follows macOS appearance, not this file's
# active theme. Switching the active theme here will not change Ghostty --
# update that line by hand to match.
THEMING_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/theming"

# Name of the active theme, from the `active-theme` key file. Falls back to
# "flexoki" if the file is missing or empty.
theming_active_theme() {
  raw="$(cat "$THEMING_DIR/active-theme" 2>/dev/null | tr -d '[:space:]')"
  echo "${raw:-flexoki}"
}

# Sets THEME_* vars (see roles above) for the active theme and the given
# mode ("dark" or "light").
theming_colors() {
  theme="$(theming_active_theme)"
  theme_file="$THEMING_DIR/themes/$theme.sh"
  if [ ! -f "$theme_file" ]; then
    echo "theming_colors: unknown theme '$theme' (no $theme_file)" >&2
    return 1
  fi
  . "$theme_file"
  theme_colors "$1"
}
