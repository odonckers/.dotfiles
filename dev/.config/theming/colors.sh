#!/usr/bin/env sh
# Theme-agnostic color loader shared by tmux, fzf, and delta. The selected
# theme and its semantic roles live under appearance in dotfiles/config.json.
# `dots appearance apply` translates the same config for applications that
# require native configuration files.
#
# Every theme sets THEME_{BG,BG_2,UI,UI_2,UI_3,TX_2,TX,ACCENT,
# ACCENT_2,ADDED,REMOVED,INFO} for dark and light modes.
# Tokens are named for the ROLE they fill, never for a hue, so a theme with a
# blue primary accent drops into the slot a yellow one filled:
#   bg / bg-2        base background / a step up (status bar, fzf bg+)
#   ui / ui-2 / ui-3 panel backgrounds and unfocused borders, low to high
#   tx / tx-2 / tx-3 primary / muted / faint foreground text
#   accent            primary accent -- active pane border, current tab,
#                      selected row in tmux's choosers and menus
#   accent-2          secondary accent -- fzf pointer/prompt
#   added             added-line markers
#   removed           removed-line markers, and fzf's border/marker
#   info              info/spinner accents
DOTFILES_CONFIG_DIR="${DOTFILES_CONFIG_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles}"
if [ ! -f "$DOTFILES_CONFIG_DIR/config.sh" ]; then
  DOTFILES_CONFIG_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}/dev/.config/dotfiles"
fi
if [ ! -f "$DOTFILES_CONFIG_DIR/config.sh" ]; then
  echo "colors.sh: cannot find the dotfiles appearance config" >&2
  return 1 2>/dev/null || exit 1
fi
# shellcheck source=/dev/null
. "$DOTFILES_CONFIG_DIR/config.sh"

theming_active_theme() {
  dots_appearance_theme
}

theming_colors() {
  theme="$(theming_active_theme)"
  mode="$1"
  case "$mode" in
    dark | light) ;;
    *)
      echo "theming_colors: unknown mode '$mode' (expected dark|light)" >&2
      return 1
      ;;
  esac

  values="$(dots_config_prefix "appearance.themes.$theme.variants.$mode.colors")" || {
    echo "theming_colors: theme '$theme' has no $mode palette" >&2
    return 1
  }

  unset THEME_BG THEME_BG_2 THEME_UI THEME_UI_2 THEME_UI_3
  unset THEME_TX THEME_TX_2 THEME_ACCENT THEME_ACCENT_2
  unset THEME_ADDED THEME_REMOVED THEME_INFO

  tab="$(printf '\t')"
  while IFS="$tab" read -r role value; do
    case "$role" in
      bg) THEME_BG="$value" ;;
      bg2) THEME_BG_2="$value" ;;
      ui) THEME_UI="$value" ;;
      ui2) THEME_UI_2="$value" ;;
      ui3) THEME_UI_3="$value" ;;
      text) THEME_TX="$value" ;;
      text2) THEME_TX_2="$value" ;;
      accent) THEME_ACCENT="$value" ;;
      accent2) THEME_ACCENT_2="$value" ;;
      added) THEME_ADDED="$value" ;;
      removed) THEME_REMOVED="$value" ;;
      info) THEME_INFO="$value" ;;
    esac
  done <<EOF
$values
EOF

  required="${THEME_BG:-}${THEME_BG_2:-}${THEME_UI:-}${THEME_UI_2:-}${THEME_UI_3:-}${THEME_TX:-}${THEME_TX_2:-}${THEME_ACCENT:-}${THEME_ACCENT_2:-}${THEME_ADDED:-}${THEME_REMOVED:-}${THEME_INFO:-}"
  if [ -z "$required" ]; then
    echo "theming_colors: incomplete $theme $mode palette" >&2
    return 1
  fi
}
