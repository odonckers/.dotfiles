return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'MunifTanjim/nui.nvim',
    },
    lazy = false, -- neo-tree will lazily load itself
    opts = {
        source_selector = {
            winbar = true,
            statusline = false,
        },
    },
    keys = {
        { '<leader>E', '<cmd>Neotree<cr>', desc = 'Explore files' },
    },
}
