---@module "lazy"
---@type LazySpec
return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    ---@module "harpoon"
    ---@type HarpoonConfig
    opts = {
        settings = {
            save_on_toggle = true,
            sync_on_ui_close = true,
        },
    },
    config = function(_, opts)
        local harpoon = require('harpoon')
        harpoon:setup(opts)

        local harpoon_extensions = require('harpoon.extensions')
        harpoon:extend(harpoon_extensions.builtins.highlight_current_file())
    end,
    keys = {
        {
            '<leader>hh',
            function()
                local harpoon = require('harpoon')
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end,
            desc = 'Open harpoon list',
        },
        { '<leader>ha', function() require('harpoon'):list():add() end, desc = 'Add file to harpoon list' },
        { '<leader>h1', function() require('harpoon'):list():select(1) end, desc = 'Harpoon 1' },
        { '<leader>h2', function() require('harpoon'):list():select(2) end, desc = 'Harpoon 2' },
        { '<leader>h3', function() require('harpoon'):list():select(3) end, desc = 'Harpoon 3' },
        { '<leader>h4', function() require('harpoon'):list():select(4) end, desc = 'Harpoon 4' },
        { '<leader>h5', function() require('harpoon'):list():select(5) end, desc = 'Harpoon 5' },
        { '<leader>h6', function() require('harpoon'):list():select(6) end, desc = 'Harpoon 6' },
        { '<leader>h7', function() require('harpoon'):list():select(7) end, desc = 'Harpoon 7' },
        { '<leader>h8', function() require('harpoon'):list():select(8) end, desc = 'Harpoon 8' },
        { '<leader>h9', function() require('harpoon'):list():select(9) end, desc = 'Harpoon 9' },
        { ']h', function() require('harpoon'):list():next() end, desc = 'Next harpoon' },
        { '[h', function() require('harpoon'):list():prev() end, desc = 'Previous harpoon' },
    },
}
