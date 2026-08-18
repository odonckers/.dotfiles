-- Jellybeans for WezTerm
-- Upstream: https://github.com/wtfox/jellybeans.nvim/tree/main/extras/wezterm

local M = {}

function M.colors()
    return {
        foreground = '#e8e8d3',
        background = '#151515',
        cursor_bg = '#e8e8d3',
        cursor_fg = '#151515',
        cursor_border = '#e8e8d3',
        selection_fg = '#151515',
        selection_bg = '#888888',
        ansi = { '#101010', '#b05050', '#99ad6a', '#dad085', '#8197bf', '#c6b6ee', '#2b5b77', '#c7c7c7' },
        brights = { '#404040', '#cf6a4c', '#99ad6a', '#ffb964', '#8fbfdc', '#c6b6ee', '#668799', '#ffffff' },
        tab_bar = {
            background = '#151515',
            active_tab = { bg_color = '#1c1c1c', fg_color = '#e8e8d3' },
            inactive_tab = { bg_color = '#101010', fg_color = '#888888' },
            inactive_tab_hover = { bg_color = '#1c1c1c', fg_color = '#a0a8b0' },
            new_tab = { bg_color = '#101010', fg_color = '#888888' },
            new_tab_hover = { bg_color = '#1c1c1c', fg_color = '#a0a8b0' },
        },
    }
end

function M.window_frame()
    return { active_titlebar_bg = '#151515', inactive_titlebar_bg = '#151515' }
end

return M
