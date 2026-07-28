#!/usr/bin/env sh
# Modus Soft -- Modus (https://protesilaos.com/emacs/modus-themes) with the
# backgrounds lifted one "tick" off the pure extremes: a very dark grey instead
# of pure black (dark), a slightly-grey white instead of pure white (light).
#
# CALCULATION -- "5% value change computed against the hex value":
#   5% of the 0-255 channel range = 255 * 0.05 = 12.75 -> round to 13 = 0x0D.
#   Every affected color is a pure grey (R = G = B), so the same signed 13-unit
#   offset is applied to all three channels, keeping it neutral; clamp to 0..255.
#   Dark backgrounds move +13 (toward light); light backgrounds move -13 (toward
#   dark). ONLY background/surface neutrals move -- TX/TX_2 (text) and every
#   chromatic accent are left at their canonical Modus values. Applying +13/-13
#   to ALL background neutrals (not just the base) preserves the exact step
#   spacing between surfaces, and keeps light BG distinct from BG_2 (both would
#   otherwise be #F2F2F2). Full derivation: ../MODUS-SOFT.md.
#
# Sets THEME_{BG,BG_2,UI,UI_2,UI_3,TX_2,TX,ACCENT,ACCENT_2,ADDED,REMOVED,INFO}
# for the given mode ("dark" or "light"). See ../colors.sh for what each token
# means. Only the five background-neutral tokens differ from themes/modus.sh.
theme_colors() {
  case "$1" in
    dark)
      # backgrounds +13: #000000->#0D0D0D #1E1E1E->#2B2B2B #303030->#3D3D3D
      #                  #535353->#606060 #646464->#717171
      THEME_BG=#0D0D0D;      THEME_BG_2=#2B2B2B
      THEME_UI=#3D3D3D;      THEME_UI_2=#606060;    THEME_UI_3=#717171
      THEME_TX=#FFFFFF;      THEME_TX_2=#989898
      THEME_ACCENT=#2FAFFF;  THEME_ACCENT_2=#FEACD0
      THEME_ADDED=#44BC44;   THEME_REMOVED=#FF5F59
      THEME_INFO=#00D3D0
      ;;
    light)
      # backgrounds -13: #FFFFFF->#F2F2F2 #F2F2F2->#E5E5E5 #E0E0E0->#D3D3D3
      #                  #C4C4C4->#B7B7B7 #9F9F9F->#929292
      THEME_BG=#F2F2F2;      THEME_BG_2=#E5E5E5
      THEME_UI=#D3D3D3;      THEME_UI_2=#B7B7B7;    THEME_UI_3=#929292
      THEME_TX=#000000;      THEME_TX_2=#595959
      THEME_ACCENT=#0031A9;  THEME_ACCENT_2=#721045
      THEME_ADDED=#006800;   THEME_REMOVED=#A60000
      THEME_INFO=#005E8B
      ;;
    *)
      echo "modus-soft theme_colors: unknown mode '$1' (expected dark|light)" >&2
      return 1
      ;;
  esac
}
