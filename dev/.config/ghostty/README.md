# ghostty

My [Ghostty](https://ghostty.org) terminal emulator config.

## Structure

- `config` - the single config file, well-commented with section headers.
- `themes/vague` - a spare copy of the [vague-ghostty](https://github.com/vague-theme/vague-ghostty)
  theme, kept for reference/future use. The active theme is Ghostty's built-in `Flexoki Dark`,
  not this file.

## Key settings

- **Theme**: `Flexoki Dark` (built-in).
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
