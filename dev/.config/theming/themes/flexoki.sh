#!/usr/bin/env sh
# Flexoki (https://stephango.com/flexoki), dark and light.
# Values and token names are pulled straight from flexoki-neovim's
# palette.lua so every tool renders the exact same swatches nvim does.
#
# Sets THEME_{BG,BG_2,UI,UI_2,UI_3,TX_2,TX,RE_2,GR_2,YE,YE_2,CY_2} for the
# given mode ("dark" or "light"). See ../colors.sh for what each token means
# and is used for -- every theme dropped into this directory must set the
# same set of tokens.
theme_colors() {
  case "$1" in
    dark)
      THEME_BG=#100F0F;  THEME_BG_2=#1C1B1A
      THEME_UI=#282726;  THEME_UI_2=#343331;  THEME_UI_3=#403E3C
      THEME_TX_2=#878580; THEME_TX=#CECDC3
      THEME_RE_2=#AF3029; THEME_GR_2=#66800B
      THEME_YE=#D0A215;   THEME_YE_2=#AD8301
      THEME_CY_2=#24837B
      ;;
    light)
      THEME_BG=#FFFCF0;  THEME_BG_2=#F2F0E5
      THEME_UI=#E6E4D9;  THEME_UI_2=#DAD8CE;  THEME_UI_3=#CECDC3
      THEME_TX_2=#6F6E69; THEME_TX=#100F0F
      THEME_RE_2=#D14D41; THEME_GR_2=#879A39
      THEME_YE=#AD8301;   THEME_YE_2=#D0A215
      THEME_CY_2=#3AA99F
      ;;
    *)
      echo "flexoki theme_colors: unknown mode '$1' (expected dark|light)" >&2
      return 1
      ;;
  esac
}
