---@module "lazy"
---@type LazySpec
return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
        preset = 'helix',
        icons = { mappings = false },
        spec = {
            {
                '<leader>b',
                group = 'Buffers',
                expand = function() return require('which-key.extras').expand.buf() end,
            },
            { '<leader>c', group = 'Quickfix list' },
            { '<leader>d', group = 'Diagnostics' },
            { '<leader>g', group = 'Git' },
            { '<leader>gt', group = 'Toggle' },
            { '<leader>h', group = 'Harpoon' },
            { '<leader>n', group = 'No Neck Pain' },
            { '<leader>o', group = 'Obsidian' },
            { '<leader>t', group = 'Test' },
            { '<leader>tr', group = 'Run' },
            { '<leader>w', proxy = '<C-w>', group = 'Windows' },
        },
    },
}
