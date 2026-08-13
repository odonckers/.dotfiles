local wezterm = require('wezterm')

local M = {}

local function read_config()
    local config_home = os.getenv('XDG_CONFIG_HOME') or (wezterm.home_dir .. '/.config')
    local path = config_home .. '/dotfiles/config.json'
    local file, error_message = io.open(path, 'r')
    if not file then
        error('dots appearance config not found: ' .. path .. ': ' .. error_message)
    end

    local contents = file:read('*a')
    file:close()
    return wezterm.json_parse(contents)
end

function M.theme_module()
    local config = read_config()
    return assert(
        config.appearance.applications.wezterm.themeModuleOverride,
        'dots config is missing the WezTerm theme module'
    )
end

function M.terminal_font()
    local config = read_config()
    return assert(config.terminal.font, 'dots config is missing the terminal font profile')
end

return M
