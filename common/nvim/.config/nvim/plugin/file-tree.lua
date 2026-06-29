require('neo-tree').setup({
    default_component_configs = {
        indent = {
            padding = 0, -- extra padding on left hand side
        },
        icon = {
            enabled = false,
        },
    },
    source_selector = {
        winbar = false,
        statusline = true,
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
        width = 52,
    },
})

vim.keymap.set('n', '<leader>E', '<cmd>Neotree toggle<cr>', { desc = 'Toggle explorer' })
vim.keymap.set('n', '<leader>F', '<cmd>Neotree filesystem<cr>', { desc = 'Explore files' })
vim.keymap.set('n', '<leader>B', '<cmd>Neotree buffers<cr>', { desc = 'Explore buffers' })
vim.keymap.set('n', '<leader>G', '<cmd>Neotree git_status<cr>', { desc = 'Explore git' })
