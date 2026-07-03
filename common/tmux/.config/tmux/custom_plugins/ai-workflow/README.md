# tmux AI Workflow

Pane-scoped status for AI CLI sessions. The tmux UI prefers explicit hook
reports and only falls back to conservative command-name detection for panes
whose current command is exactly `opencode`, `claude`, `codex`, or a packaged
Codex binary such as `codex-aarch64-a`.

The fzf preview renders fullscreen TUIs from the current alternate screen
instead of scrollback, so Codex, Claude, OpenCode, editors, and other
fullscreen interfaces keep their visible grid shape in the preview pane.

Agent panes also update their tmux tab title. The title reflects the
highest-priority agent in that tab and groups its states, such as
`⌘ codex [waiting]` or `⌘ codex [waiting, ready 3]`. The original tab name is
restored after the last agent state clears.

## Statuses

- `waiting`: needs attention or input; highest priority in `status-right`
- `running`: work is in progress
- `active`: alive but state is not more specific
- `idle`: ready or complete

## Hook Command

Use this from Codex, Claude, or OpenCode hooks:

```sh
$HOME/.config/tmux/custom_plugins/ai-workflow/scripts/report.sh codex running "editing files"
$HOME/.config/tmux/custom_plugins/ai-workflow/scripts/report.sh codex waiting "review needed"
$HOME/.config/tmux/custom_plugins/ai-workflow/scripts/report.sh codex idle
```

Clear explicit state for the current pane:

```sh
$HOME/.config/tmux/custom_plugins/ai-workflow/scripts/clear.sh
```

The scripts use `TMUX_PANE` when present, so a hook running inside the CLI's
tmux pane reports to the correct pane without extra arguments.

## Event Adapter

For CLIs that expose lifecycle events, call the provider-specific adapter:

```sh
$HOME/.config/tmux/custom_plugins/ai-workflow/hooks/claude.sh UserPromptSubmit "working"
$HOME/.config/tmux/custom_plugins/ai-workflow/hooks/opencode.sh PermissionRequest "permission needed"
$HOME/.config/tmux/custom_plugins/ai-workflow/hooks/codex.sh Stop
```

The adapter maps:

- `PermissionRequest`, `Notification`, `waiting`, `needs_input` -> `waiting`
- `UserPromptSubmit`, `PreToolUse`, `PostToolUse`, `running` -> `running`
- `Stop`, `SessionStart`, `idle`, `ready`, `complete` -> `idle`

## Claude Config

Claude reads hooks from `~/.claude/settings.json`. This dotfiles repo wires
that through `common/claude/.claude/settings.json`:

```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "$HOME/.config/tmux/custom_plugins/ai-workflow/hooks/claude.sh UserPromptSubmit working"
          }
        ]
      }
    ],
    "PreToolUse": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "$HOME/.config/tmux/custom_plugins/ai-workflow/hooks/claude.sh PreToolUse working"
          }
        ]
      }
    ],
    "Notification": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "$HOME/.config/tmux/custom_plugins/ai-workflow/hooks/claude.sh Notification 'needs attention'"
          }
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "$HOME/.config/tmux/custom_plugins/ai-workflow/hooks/claude.sh Stop"
          }
        ]
      }
    ]
  }
}
```

## OpenCode Config

OpenCode uses a plugin entry in `opencode.json`. This dotfiles repo includes
`common/opencode/.config/opencode/opencode.json` with:

```json
{
  "plugin": [
    "$HOME/.config/tmux/custom_plugins/ai-workflow/integrations/opencode/tmux-ai-workflow.js"
  ]
}
```

The plugin lives at:

```text
common/tmux/.config/tmux/custom_plugins/ai-workflow/integrations/opencode/tmux-ai-workflow.js
```

It maps OpenCode events to tmux state:

- `permission.asked`, `question.asked` -> `waiting`
- `message.part.delta`, `chat.message`, tool events -> `running`
- `session.idle`, idle session status -> `idle`

## Codex Hook Snippet

Codex discovers hooks from `~/.codex/hooks.json`, `~/.codex/config.toml`, and
project `.codex/` layers. A user-level `~/.codex/hooks.json` can use:

```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "$HOME/.config/tmux/custom_plugins/ai-workflow/hooks/codex.sh UserPromptSubmit working",
            "timeout": 5,
            "statusMessage": "Updating tmux AI status"
          }
        ]
      }
    ],
    "PermissionRequest": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "$HOME/.config/tmux/custom_plugins/ai-workflow/hooks/codex.sh PermissionRequest 'permission needed'",
            "timeout": 5,
            "statusMessage": "Updating tmux AI status"
          }
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "$HOME/.config/tmux/custom_plugins/ai-workflow/hooks/codex.sh Stop",
            "timeout": 5,
            "statusMessage": "Updating tmux AI status"
          }
        ]
      }
    ]
  }
}
```

After changing Codex hooks, use `/hooks` in Codex to review and trust the new
command hooks.
