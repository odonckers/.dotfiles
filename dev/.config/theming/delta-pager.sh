#!/usr/bin/env sh
# Runs delta as lazygit's diff pager with the active theme's chrome
# (file/hunk headers, line numbers, commit color) for the current OS
# appearance. Content syntax-highlighting is left to delta's own
# --dark/--light default theme -- most themes here won't have a matching
# bat/delta syntax theme to port.
set -eu

DIR="$(cd "$(dirname "$0")" && pwd)"
. "$DIR/colors.sh"
. "$DIR/appearance.sh"

MODE="$(theming_mode)"
theming_colors "$MODE"

exec delta \
  "--$MODE" \
  --line-numbers \
  --line-numbers-left-style "$THEME_TX_2" \
  --line-numbers-right-style "$THEME_TX_2" \
  --line-numbers-minus-style "$THEME_RE_2" \
  --line-numbers-plus-style "$THEME_GR_2" \
  --line-numbers-zero-style "$THEME_UI_3" \
  --file-style "$THEME_TX bold" \
  --file-decoration-style "$THEME_UI_3 ul" \
  --hunk-header-style "file line-number syntax" \
  --hunk-header-decoration-style "$THEME_UI_3 box" \
  --hunk-header-file-style "$THEME_TX" \
  --hunk-header-line-number-style "$THEME_YE" \
  --commit-style "$THEME_YE bold" \
  --commit-decoration-style "none" \
  "$@"
