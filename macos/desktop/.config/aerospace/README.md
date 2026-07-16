# aerospace

My [AeroSpace](https://github.com/nikitabobko/AeroSpace) tiling window manager config for
macOS (`aerospace.toml`, config-version 2).

## Structure

- Starts at login; layout normalizations enabled (flatten containers, opposite orientation for
  nested containers).
- Default layout is `tiles` with `auto` orientation; `accordion-padding = 80`.
- `[workspace-to-monitor-force-assignment]` pins workspaces 1-9 to specific monitors, with
  inline comments describing intended use (browser, work terminal, RDP, notes, Teams, Spotify).
- `[[on-window-detected]]` rules auto-route apps to workspaces: Cypress -> 4, Microsoft Remote
  Desktop -> 6, Teams -> 8, Spotify -> 9, plus a rule forcing LibreWolf Picture-in-Picture
  windows to float.
- `[gaps]` - 10px inner gaps, 0 outer gaps except `outer.top = 1`.
- Single `[mode.main.binding]` mode (no secondary/service mode).

## Key bindings

- `alt-comma` / `alt-period` / `alt-slash` - toggle accordion h/v, floating/tiling, tiles h/v.
- `alt-h/j/k/l` - focus window, wrapping across all monitors.
- `alt-shift-h/j/k/l` - move window (bounded to the outer frame, no wrap).
- `ctrl-alt-h/j/k/l` - join container in that direction.
- `alt-minus` / `alt-equal` - smart resize.
- `alt-1..9` - switch workspace; `alt-shift-1..9` - move window to workspace.
- `alt-tab` - workspace back-and-forth; `alt-shift-tab` - move workspace to next monitor.
- `alt-0` - flatten workspace tree; `alt-z` - fullscreen; `alt-shift-r` - reload config.
- `cmd-h` / `cmd-alt-h` unbound to disable macOS's native hide-app/hide-others.

## Notable settings

- `automatically-unhide-macos-hidden-apps = true`.
- Mouse-follows-focus (`on-focused-monitor-changed`) is present but commented out.
- `qwerty` key-mapping preset.

## Standout customizations

- App-specific workspace auto-assignment (Cypress, RDP, Teams, Spotify) and a
  Picture-in-Picture-to-floating rule for LibreWolf.
- Paired with [`aerospace-swipe`](../aerospace-swipe), a companion trackpad-gesture daemon
  (3-finger swipe with haptics, natural-swipe, wrap-around) for swiping between AeroSpace
  workspaces.
