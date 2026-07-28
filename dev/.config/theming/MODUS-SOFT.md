# Modus Soft

A variant of the [Modus themes](https://protesilaos.com/emacs/modus-themes)
(Vivendi dark / Operandi light) with the **backgrounds lifted one tick off the
pure extremes** — a very dark grey instead of pure black, a slightly-grey white
instead of pure white. Text stays pure for maximum contrast, and every accent
hue keeps its canonical, WCAG-tuned Modus value.

## The calculation

The base change is a **5% value shift computed against the hex value**:

```
5% of the 0–255 channel range = 255 × 0.05 = 12.75  →  round to 13 = 0x0D
```

Rules:

- **Greys only, all channels equal.** Every softened color is a pure grey
  (R = G = B), so the same signed 13-unit offset is applied to all three
  channels. The result stays perfectly neutral. Values are clamped to `[0, 255]`.
- **Direction.** Dark backgrounds move **+13** (toward light); light backgrounds
  move **−13** (toward dark).
- **Backgrounds only.** Only background / surface neutrals move. Foreground
  **text** and all **chromatic accents** (blue, magenta, green, red, cyan) are
  left exactly as stock Modus ships them.
- **All neutrals, not just the base.** The same +13 / −13 is applied to *every*
  background neutral in the ramp, not only the pure endpoint. This preserves the
  exact step spacing between surfaces and avoids a collision: stock light `BG_2`
  is already `#F2F2F2`, which is precisely where a −13 base lands — so `BG_2`
  must also move (to `#E5E5E5`) to stay distinct from the base.

## Derived palette

Role tokens are those of the central theming system
(`themes/modus-soft.sh`; see `colors.sh` for what each means).

### Dark (Vivendi) — backgrounds +13

| token | stock Modus | Modus Soft |
|-------|-------------|------------|
| `BG`   | `#000000` | **`#0D0D0D`** |
| `BG_2` | `#1E1E1E` | **`#2B2B2B`** |
| `UI`   | `#303030` | **`#3D3D3D`** |
| `UI_2` | `#535353` | **`#606060`** |
| `UI_3` | `#646464` | **`#717171`** |
| `TX`   | `#FFFFFF` | `#FFFFFF` (unchanged) |
| `TX_2` | `#989898` | `#989898` (unchanged) |
| accents | — | unchanged |

### Light (Operandi) — backgrounds −13

| token | stock Modus | Modus Soft |
|-------|-------------|------------|
| `BG`   | `#FFFFFF` | **`#F2F2F2`** |
| `BG_2` | `#F2F2F2` | **`#E5E5E5`** |
| `UI`   | `#E0E0E0` | **`#D3D3D3`** |
| `UI_2` | `#C4C4C4` | **`#B7B7B7`** |
| `UI_3` | `#9F9F9F` | **`#929292`** |
| `TX`   | `#000000` | `#000000` (unchanged) |
| `TX_2` | `#595959` | `#595959` (unchanged) |
| accents | — | unchanged |

## Where it's wired in

Modus Soft ships as a parallel, non-destructive variant everywhere Modus is used;
stock Modus is always one switch away.

| Surface | How | Activate |
|---------|-----|----------|
| **tmux / fzf / delta** | central `themes/modus-soft.sh` | `theming/set.sh modus-soft` |
| **tmux-palette** | `tmux-palette/themes/modus-soft{,-light}.json` | (follows the active theme name) |
| **Ghostty** | `ghostty/themes/modus-{vivendi,operandi}-soft` | `theme =` line in `ghostty/config` |
| **Neovim** | `on_colors` override in `nvim/init.lua` | automatic (follows terminal bg) |
| **Emacs** | `modus-{vivendi,operandi}-palette-overrides` in `emacs/init.el` | automatic |
| **kitty** | `kitty/themes/modus-{vivendi,operandi}-soft.conf` | `*-theme.auto.conf` includes |
| **yazi** | `yazi/flavors/modus-{vivendi,operandi}-soft.yazi` | `yazi/theme.toml` |

The **ANSI/palette mapping** for the terminal-level surfaces (Ghostty, kitty):
soften the pure-black/white `background` plus the background-role ANSI slots
(`color0`/palette 0 = "black", and the "bright black" grey slot `color8`/palette
8) by the same +13 / −13. Foreground and text-role slots stay pure.

To revert any tool, point it back at the stock `modus` variant (e.g.
`theming/set.sh modus`).
