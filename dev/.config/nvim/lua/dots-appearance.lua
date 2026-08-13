local M = {}

local function read_config()
    local config_home = vim.env.XDG_CONFIG_HOME or vim.fn.expand('~/.config')
    local path = config_home .. '/dotfiles/config.json'
    local file = io.open(path, 'r')
    if not file then
        error('dots appearance config not found: ' .. path)
    end

    local contents = file:read('*a')
    file:close()
    return vim.json.decode(contents)
end

function M.current()
    local config = read_config()
    local appearance = assert(config.appearance, 'dots config is missing appearance')
    local theme = assert(appearance.themes[appearance.theme], 'unknown dots appearance theme')
    local target = assert(theme.targets.nvim, 'dots theme has no Neovim target')

    return {
        scheme = assert(target.scheme, 'dots theme has no Neovim scheme'),
        soft = target.soft == true,
        transparent = appearance.applications.nvim.transparent == true,
        overrides = theme.overrides,
    }
end

return M
