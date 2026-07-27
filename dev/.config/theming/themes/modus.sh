#!/usr/bin/env sh
# Modus (https://protesilaos.com/emacs/modus-themes), dark and light. Dark uses
# Modus Vivendi, light uses Modus Operandi -- the WCAG-AAA accessible pair.
# Values are the themes' canonical palette hexes (plain variants, pure
# black/white backgrounds).
#
# Modus's canonical active/link color is BLUE, so this theme's accent is blue;
# accent-2 is magenta, added maps to green, removed to red, info to cyan.
#
# Sets THEME_{BG,BG_2,UI,UI_2,UI_3,TX_2,TX,ACCENT,ACCENT_2,ADDED,REMOVED,
# INFO} for the given mode ("dark" or "light"). See ../colors.sh for what
# each token means and is used for -- every theme dropped into this
# directory must set the same set of tokens.
theme_colors() {
  case "$1" in
    dark)
      THEME_BG=#000000;      THEME_BG_2=#1E1E1E
      THEME_UI=#303030;      THEME_UI_2=#535353;    THEME_UI_3=#646464
      THEME_TX=#FFFFFF;      THEME_TX_2=#989898
      THEME_ACCENT=#2FAFFF;  THEME_ACCENT_2=#FEACD0
      THEME_ADDED=#44BC44;   THEME_REMOVED=#FF5F59
      THEME_INFO=#00D3D0
      ;;
    light)
      THEME_BG=#FFFFFF;      THEME_BG_2=#F2F2F2
      THEME_UI=#E0E0E0;      THEME_UI_2=#C4C4C4;    THEME_UI_3=#9F9F9F
      THEME_TX=#000000;      THEME_TX_2=#595959
      THEME_ACCENT=#0031A9;  THEME_ACCENT_2=#721045
      THEME_ADDED=#006800;   THEME_REMOVED=#A60000
      THEME_INFO=#005E8B
      ;;
    *)
      echo "modus theme_colors: unknown mode '$1' (expected dark|light)" >&2
      return 1
      ;;
  esac
}
