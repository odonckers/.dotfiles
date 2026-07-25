#!/usr/bin/env sh
# Flexoki (https://stephango.com/flexoki), dark and light.
# Values are pulled straight from flexoki-neovim's palette.lua. Flexoki maps
# cyan to "links, active states", so this theme's accent/accent-2 are its
# cyan-400/cyan-600. Info was cyan too, so it moved to blue to stay legible
# next to the accent.
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
      THEME_ACCENT=#3AA99F;  THEME_ACCENT_2=#24837B
      THEME_ADDED=#66800B;   THEME_REMOVED=#AF3029
      THEME_INFO=#4385BE
      ;;
    light)
      THEME_BG=#FFFCF0;      THEME_BG_2=#F2F0E5
      THEME_UI=#E6E4D9;      THEME_UI_2=#DAD8CE;    THEME_UI_3=#CECDC3
      THEME_TX=#100F0F;      THEME_TX_2=#6F6E69
      THEME_ACCENT=#24837B;  THEME_ACCENT_2=#3AA99F
      THEME_ADDED=#879A39;   THEME_REMOVED=#D14D41
      THEME_INFO=#205EA6
      ;;
    *)
      echo "flexoki theme_colors: unknown mode '$1' (expected dark|light)" >&2
      return 1
      ;;
  esac
}
