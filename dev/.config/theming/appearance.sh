#!/usr/bin/env sh
# Prints "dark" or "light" for the current OS appearance.
theming_mode() {
  case "$(uname -s)" in
    Darwin)
      if defaults read -g AppleInterfaceStyle >/dev/null 2>&1; then
        echo dark
      else
        echo light
      fi
      ;;
    *)
      # No cross-desktop appearance query on Linux yet -- keep the old
      # hardcoded default.
      echo dark
      ;;
  esac
}
