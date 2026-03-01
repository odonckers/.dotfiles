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
        filesystem = {
            filtered_items = {
                visible = true,
                hide_dotfiles = false,
            },
            follow_current_file = {
                enabled = true,
                leave_dirs_open = true,
            },
        },
        window = {
            width = 56,
        },
    },
    keys = {
        { '<leader>E', '<cmd>Neotree toggle<cr>', desc = 'Toggle explorer' },
        { '<leader>F', '<cmd>Neotree filesystem<cr>', desc = 'Explore files' },
        { '<leader>B', '<cmd>Neotree buffers<cr>', desc = 'Explore buffers' },
        { '<leader>G', '<cmd>Neotree git_status<cr>', desc = 'Explore git' },
    },
}
