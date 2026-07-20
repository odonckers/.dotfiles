#!/usr/bin/env sh
# GitHub (https://primer.style), dark and light.
# Values are GitHub Primer's "Default" variants -- the same palettes behind
# Ghostty's "GitHub Dark Default" / "GitHub Light Default" and
# github-nvim-theme's github_dark_default / github_light_default.
#
# Sets THEME_{BG,BG_2,UI,UI_2,UI_3,TX_2,TX,ACCENT,ACCENT_2,ADDED,REMOVED,
# INFO} for the given mode ("dark" or "light"). See ../colors.sh for what
# each token means and is used for -- every theme dropped into this
# directory must set the same set of tokens.
#
# Tokens name roles, not hues, so GitHub's primary accent is its blue.
theme_colors() {
  case "$1" in
    dark)
      THEME_BG=#0D1117;      THEME_BG_2=#161B22
      THEME_UI=#21262D;      THEME_UI_2=#262C36;    THEME_UI_3=#30363D
      THEME_TX=#E6EDF3;      THEME_TX_2=#8B949E
      THEME_ACCENT=#58A6FF;  THEME_ACCENT_2=#58A6FF
      THEME_ADDED=#3FB950;   THEME_REMOVED=#F85149
      THEME_INFO=#39C5CF
      ;;
    light)
      THEME_BG=#FFFFFF;      THEME_BG_2=#F6F8FA
      THEME_UI=#EAEEF2;      THEME_UI_2=#D8DEE4;    THEME_UI_3=#D0D7DE
      THEME_TX=#1F2328;      THEME_TX_2=#656D76
      THEME_ACCENT=#0969DA;  THEME_ACCENT_2=#0969DA
      THEME_ADDED=#1A7F37;   THEME_REMOVED=#CF222E
      THEME_INFO=#1B7C83
      ;;
    *)
      echo "github theme_colors: unknown mode '$1' (expected dark|light)" >&2
      return 1
      ;;
  esac
}
