#!/usr/bin/env zsh

# Stows the dotfiles packages relevant to the current OS. Always targets
# $HOME/.dotfiles regardless of the shell's current working directory.
syncdots() {
  local dotfiles="$HOME/.dotfiles"
  local packages=(dev)

  case "$(uname -s)" in
    Darwin)
      packages+=(dev-macos desktop-macos)
      ;;
    Linux)
      packages+=(dev-linux desktop-linux)
      ;;
    *)
      echo "syncdots: unsupported OS $(uname -s)" >&2
      return 1
      ;;
  esac

  stow -d "$dotfiles" -t "$HOME" "${packages[@]}"
}
