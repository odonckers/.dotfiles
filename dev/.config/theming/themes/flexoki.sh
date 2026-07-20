#!/usr/bin/env sh
# Flexoki (https://stephango.com/flexoki), dark and light.
# Values are pulled straight from flexoki-neovim's palette.lua. Flexoki's
# accent tokens are yellow, so this theme's accent/accent-2 are its
# yellow-400/yellow-600.
#
# Sets THEME_{BG,BG_2,UI,UI_2,UI_3,TX_2,TX,ACCENT,ACCENT_2,ADDED,REMOVED,
# INFO} for the given mode ("dark" or "light"). See ../colors.sh for what
# each token means and is used for -- every theme dropped into this
# directory must set the same set of tokens.
theme_colors() {
  case "$1" in
    dark)
      THEME_BG=#100F0F;      THEME_BG_2=#1C1B1A
      THEME_UI=#282726;      THEME_UI_2=#343331;    THEME_UI_3=#403E3C
      THEME_TX=#CECDC3;      THEME_TX_2=#878580
      THEME_ACCENT=#D0A215;  THEME_ACCENT_2=#AD8301
      THEME_ADDED=#66800B;   THEME_REMOVED=#AF3029
      THEME_INFO=#24837B
      ;;
    light)
      THEME_BG=#FFFCF0;      THEME_BG_2=#F2F0E5
      THEME_UI=#E6E4D9;      THEME_UI_2=#DAD8CE;    THEME_UI_3=#CECDC3
      THEME_TX=#100F0F;      THEME_TX_2=#6F6E69
      THEME_ACCENT=#AD8301;  THEME_ACCENT_2=#D0A215
      THEME_ADDED=#879A39;   THEME_REMOVED=#D14D41
      THEME_INFO=#3AA99F
      ;;
    *)
      echo "flexoki theme_colors: unknown mode '$1' (expected dark|light)" >&2
      return 1
      ;;
  esac
}
