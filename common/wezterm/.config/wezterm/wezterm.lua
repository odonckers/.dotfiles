local wezterm = require('wezterm')
local config = wezterm.config_builder()

-- Basic settings
config.initial_cols = 140
config.initial_rows = 40
config.line_height = 1.1
config.window_decorations = 'RESIZE'

-- Tab bar
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

-- Font
config.font = wezterm.font('JetBrainsMono Nerd Font Mono')
config.font_size = 12

-- Theme
local theme = require('lua/vague')
config.colors = theme.colors()
config.window_frame = theme.window_frame()

wezterm.on('update-right-status', function(window, _) window:set_right_status(window:active_workspace()) end)

-- smart-splits.nvim
-- Upstream: https://github.com/mrjones2014/smart-splits.nvim?tab=readme-ov-file#wezterm
local key_to_direction_map = {
    h = 'Left',
    j = 'Down',
    k = 'Up',
    l = 'Right',
    LeftArrow = 'Left',
    DownArrow = 'Down',
    UpArrow = 'Up',
    RightArrow = 'Right',
}

local function is_vim(pane) return pane:get_user_vars().IS_NVIM == 'true' end
local function split_nav(action, key)
    return {
        key = key,
        mods = 'CTRL',
        action = wezterm.action_callback(function(win, pane)
            if is_vim(pane) then
                win:perform_action({ SendKey = { key = key, mods = 'CTRL' } }, pane)
            else
                if action == 'resize' then
                    win:perform_action({ AdjustPaneSize = { key_to_direction_map[key], 5 } }, pane)
                else
                    win:perform_action({ ActivatePaneDirection = key_to_direction_map[key] }, pane)
                end
            end
        end),
    }
end

-- Key bindings
config.leader = { key = 'a', mods = 'CTRL' }
config.keys = {
    -- command pallete
    { mods = 'CMD', key = 'P', action = wezterm.action.ActivateCommandPalette },
    { mods = 'CTRL', key = 'P', action = wezterm.action.ActivateCommandPalette },

    -- move between split panes
    split_nav('move', 'h'),
    split_nav('move', 'j'),
    split_nav('move', 'k'),
    split_nav('move', 'l'),

    -- resize panes
    split_nav('resize', 'LeftArrow'),
    split_nav('resize', 'DownArrow'),
    split_nav('resize', 'UpArrow'),
    split_nav('resize', 'RightArrow'),

    -- splitting
    { mods = 'LEADER', key = '-', action = wezterm.action.SplitVertical({ domain = 'CurrentPaneDomain' }) },
    { mods = 'LEADER', key = '\\', action = wezterm.action.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },

    -- zoom
    { mods = 'LEADER', key = 'z', action = wezterm.action.TogglePaneZoomState },

    -- activate copy mode or vim mode
    { mods = 'LEADER', key = '[', action = wezterm.action.ActivateCopyMode },

    -- Show the launcher in fuzzy selection mode and have it list all workspaces
    -- and allow activating one.
    -- { mods = 'CTRL', key = 's', action = wezterm.action.ShowLauncherArgs({ flags = 'FUZZY|WORKSPACES' }) },
}

return config
