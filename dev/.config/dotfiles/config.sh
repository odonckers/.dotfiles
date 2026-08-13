#!/bin/sh
# Shared reader for ~/.config/dotfiles/config.json.

dots_config_dir() {
  if [ -n "${DOTFILES_CONFIG_DIR:-}" ]; then
    printf '%s\n' "$DOTFILES_CONFIG_DIR"
    return
  fi

  xdg_dir="${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles"
  if [ -f "$xdg_dir/config.json" ]; then
    printf '%s\n' "$xdg_dir"
  else
    printf '%s\n' "${DOTFILES_DIR:-$HOME/.dotfiles}/dev/.config/dotfiles"
  fi
}

dots_config_get() {
  config_dir="$(dots_config_dir)"
  awk -v query="$1" -f "$config_dir/json.awk" "$config_dir/config.json"
}

dots_config_prefix() {
  config_dir="$(dots_config_dir)"
  awk -v prefix="$1" -f "$config_dir/json.awk" "$config_dir/config.json"
}

dots_appearance_theme() {
  dots_config_get appearance.theme
}

dots_appearance_target() {
  theme="$(dots_appearance_theme)"
  dots_config_get "appearance.themes.$theme.targets.$1.$2"
}
