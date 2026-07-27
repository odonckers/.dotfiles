#!/usr/bin/env sh
# Rosé Pine (https://rosepinetheme.com), dark and light. Dark uses the main
# Rosé Pine variant; light uses Rosé Pine Dawn. Values are the palettes'
# canonical hexes.
#
# Rosé Pine has no single "accent" token -- it exposes named hues (love, rose,
# pine, foam, iris, gold). This theme's accent is IRIS, its signature lilac;
# accent-2 is foam (teal), added maps to pine, removed to love, info to gold.
#
# Sets THEME_{BG,BG_2,UI,UI_2,UI_3,TX_2,TX,ACCENT,ACCENT_2,ADDED,REMOVED,
# INFO} for the given mode ("dark" or "light"). See ../colors.sh for what
# each token means and is used for -- every theme dropped into this
# directory must set the same set of tokens.
theme_colors() {
  case "$1" in
    dark)
      THEME_BG=#191724;      THEME_BG_2=#1F1D2E
      THEME_UI=#26233A;      THEME_UI_2=#403D52;    THEME_UI_3=#524F67
      THEME_TX=#E0DEF4;      THEME_TX_2=#908CAA
      THEME_ACCENT=#C4A7E7;  THEME_ACCENT_2=#9CCFD8
      THEME_ADDED=#31748F;   THEME_REMOVED=#EB6F92
      THEME_INFO=#F6C177
      ;;
    light)
      THEME_BG=#FAF4ED;      THEME_BG_2=#F4EDE8
      THEME_UI=#F2E9E1;      THEME_UI_2=#DFDAD9;    THEME_UI_3=#CECACD
      THEME_TX=#575279;      THEME_TX_2=#797593
      THEME_ACCENT=#907AA9;  THEME_ACCENT_2=#56949F
      THEME_ADDED=#286983;   THEME_REMOVED=#B4637A
      THEME_INFO=#EA9D34
      ;;
    *)
      echo "rose-pine theme_colors: unknown mode '$1' (expected dark|light)" >&2
      return 1
      ;;
  esac
}
