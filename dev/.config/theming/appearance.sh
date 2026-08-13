#!/usr/bin/env sh
# Prints the configured dark/light mode. "system" follows macOS appearance
# and uses appearance.fallbackMode on platforms without a shared query.
DOTFILES_CONFIG_DIR="${DOTFILES_CONFIG_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles}"
if [ ! -f "$DOTFILES_CONFIG_DIR/config.sh" ]; then
  DOTFILES_CONFIG_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}/dev/.config/dotfiles"
fi
if [ ! -f "$DOTFILES_CONFIG_DIR/config.sh" ]; then
  echo "appearance.sh: cannot find the dotfiles appearance config" >&2
  return 1 2>/dev/null || exit 1
fi
# shellcheck source=/dev/null
. "$DOTFILES_CONFIG_DIR/config.sh"

theming_mode() {
  configured="$(dots_config_get appearance.mode)" || return 1
  case "$configured" in
    dark | light)
      echo "$configured"
      ;;
    system)
      case "$(uname -s)" in
        Darwin)
          if defaults read -g AppleInterfaceStyle >/dev/null 2>&1; then
            echo dark
          else
            echo light
          fi
          ;;
        *)
          dots_config_get appearance.fallbackMode
          ;;
      esac
      ;;
    *)
      echo "theming_mode: unknown mode '$configured' (expected system|dark|light)" >&2
      return 1
      ;;
  esac
}
