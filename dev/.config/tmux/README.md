# tmux

My tmux config. `tmux.conf` (~270 lines) is organized into clear sections - shell & terminal,
Claude Code integration, windows & panes, cursor & scrollbars, status bar, pane borders, copy
mode, key bindings, and plugins (loaded last so plugins can override earlier settings). The
file opens with a cheat-sheet comment explaining tmux's `set`/`setw`/`set-environment`
semantics and the `-g`/`-a`/`-s` flags.

## Plugins

Managed via [TPM](https://github.com/tmux-plugins/tpm), bootstrapped by `run
'~/.tmux/plugins/tpm/tpm'` at the end of `tmux.conf`. Plugins are vendored under `plugins/`
rather than fetched at runtime:

- `tpm` - the plugin manager itself
- `tmux-sensible` - sane baseline defaults
- `tmux-sessionist` - session management keybindings
- `tmux-pain-control` - pane split/navigation bindings
- `smart-splits.nvim` - unified pane navigation/resizing across tmux and vim splits
- `tmux-fzf` - fzf-powered session/window/pane picker
- `tmux-task-monitor` - background task monitoring
- `tmux-notify` - desktop notifications on pane activity
- `tmux-palette` - command palette
- `tmux-resurrect` - save/restore sessions across restarts (tracks nvim, `opencode`, `claude`,
  `lazygit`, `opensessions` processes)

`opensessions` and `tmux-agent-indicator` are also vendored under `plugins/` but not currently
wired into `tmux.conf` - staged for future use.

## Key bindings & settings

- Prefix stays default (`C-b`).
- `prefix s` / `prefix w` - name-sorted session/window choosers.
- `prefix e` - fzf popup picker over dev repos.
- `C-s` - fzf session switcher.
- `C-Space` - command palette.
- `C-h/j/k/l` and `C-arrow` - unified pane navigation/resizing (tmux + nvim splits).
- Copy mode uses vi keys, hybrid line numbers, and custom `v`/`y` selection/yank bindings.
- Theme: warm dark palette (`#1C1B1A` background, `#3AA99F` cyan accent), status bar on top,
  minimal `#S`/`#H` segments, styled window tabs and single-line pane borders with a
  mouse-driven pane-border quick-action menu.

## Standout customizations

- First-class Claude Code terminal integration (passthrough, extended keys,
  `CLAUDE_CODE_TMUXTRUECOLOR`).
- Mouse-only pane-border context menu.
- A heavily annotated, teaching-style config file meant to be read, not just sourced.
