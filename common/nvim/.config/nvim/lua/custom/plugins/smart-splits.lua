return {
    'mrjones2014/smart-splits.nvim',
    lazy = false,
    config = function()
        local splits = require('smart-splits')
        splits.setup({ default_amount = 5 })

        -- Navigate splits
        vim.keymap.set('n', '<C-h>', splits.move_cursor_left)
        vim.keymap.set('n', '<C-j>', splits.move_cursor_down)
        vim.keymap.set('n', '<C-k>', splits.move_cursor_up)
        vim.keymap.set('n', '<C-l>', splits.move_cursor_right)
        vim.keymap.set('n', '<C-\\>', splits.move_cursor_previous)

        -- Resize splits
        vim.keymap.set('n', '<C-left>', splits.resize_left)
        vim.keymap.set('n', '<C-down>', splits.resize_down)
        vim.keymap.set('n', '<C-up>', splits.resize_up)
        vim.keymap.set('n', '<C-right>', splits.resize_right)

        -- Swap splits
        vim.keymap.set('n', '<C-S-left>', splits.swap_buf_left)
        vim.keymap.set('n', '<C-S-down>', splits.swap_buf_down)
        vim.keymap.set('n', '<C-S-up>', splits.swap_buf_up)
        vim.keymap.set('n', '<C-S-right>', splits.swap_buf_right)
    end,
}
