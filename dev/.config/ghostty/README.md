# ghostty

My [Ghostty](https://ghostty.org) terminal emulator config.

## Structure

- `config` - the single config file, well-commented with section headers.
- `themes/modus-vivendi`, `themes/modus-operandi` - the active themes: the stock
  [Modus](https://protesilaos.com/emacs/modus-themes) pair (WCAG-AAA, pure
  black/white backgrounds).
- `themes/vague` - a spare copy of the [vague-ghostty](https://github.com/vague-theme/vague-ghostty)
  theme, kept for reference/future use. Not the active theme.

## Key settings

- **Theme**: generated from the shared
  [`dotfiles/config.json`](../dotfiles/config.json) appearance settings.
- **Font**: JetBrainsMono Nerd Font Mono @ 12pt, `font-thicken = false` (native weights, no
  synthetic bold), with a slightly taller cell height (`adjust-cell-height = 20%`) for extra
  line spacing.
- **Window**: 10px padding balanced across the window, pixel-smooth resizing
  (`window-step-resize = false`), and window/tab/split layout always restored on relaunch
  (`window-save-state = always`).
- **Cursor**: auto-contrasting cursor colors (`cell-foreground`/`cell-background`), Kitty-style.
- **Background**: opacity and blur are also controlled by the shared appearance config.
- **Keybindings**: `cmd+shift+i` prompts for a custom tab title.

## Standout customizations

- Forces `TERM=xterm-256color` for child processes (better tmux/terminfo compatibility) while
  Ghostty itself still reports `xterm-ghostty`.
- Enables `ssh-env`/`ssh-terminfo` shell integration for smoother remote SSH sessions.
- macOS tuning: non-native fullscreen (menu bar stays visible), hidden titlebar, and
  `macos-option-as-alt = left` so left Option acts as Alt in shells/TUIs instead of producing
  macOS compose characters.
