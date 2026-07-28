# ghostty

My [Ghostty](https://ghostty.org) terminal emulator config.

## Structure

- `config` - the single config file, well-commented with section headers.
- `themes/modus-vivendi-soft`, `themes/modus-operandi-soft` - the active custom
  themes: [Modus](https://protesilaos.com/emacs/modus-themes) with backgrounds
  lifted one 5% tick off pure black/white. See
  [`dev/.config/theming/MODUS-SOFT.md`](../theming/MODUS-SOFT.md) for the math.
- `themes/vague` - a spare copy of the [vague-ghostty](https://github.com/vague-theme/vague-ghostty)
  theme, kept for reference/future use. Not the active theme.

## Key settings

- **Theme**: Modus Soft, following macOS appearance -- custom
  `modus-vivendi-soft` / `modus-operandi-soft` theme files in `themes/`
  (`theme = dark:modus-vivendi-soft, light:modus-operandi-soft`). tmux and fzf
  mirror this switch too; see [`dev/.config/theming`](../theming). Neovim already
  follows the terminal's `background` automatically, so it needs no separate wiring. This line
  is tied to macOS appearance only, not to `theming/active-theme` -- update it by hand if you
  switch the active theme away from Modus Soft.
- **Font**: JetBrainsMono Nerd Font Mono @ 12pt, `font-thicken = false` (native weights, no
  synthetic bold), with a slightly taller cell height (`adjust-cell-height = 20%`) for extra
  line spacing.
- **Window**: 10px padding balanced across the window, pixel-smooth resizing
  (`window-step-resize = false`), and window/tab/split layout always restored on relaunch
  (`window-save-state = always`).
- **Cursor**: auto-contrasting cursor colors (`cell-foreground`/`cell-background`), Kitty-style.
- **Background**: fully opaque, no blur.
- **Keybindings**: `cmd+shift+i` prompts for a custom tab title.

## Standout customizations

- Forces `TERM=xterm-256color` for child processes (better tmux/terminfo compatibility) while
  Ghostty itself still reports `xterm-ghostty`.
- Enables `ssh-env`/`ssh-terminfo` shell integration for smoother remote SSH sessions.
- macOS tuning: non-native fullscreen (menu bar stays visible), hidden titlebar, and
  `macos-option-as-alt = left` so left Option acts as Alt in shells/TUIs instead of producing
  macOS compose characters.
