return {
    'mrjones2014/smart-splits.nvim',
    build = './kitty/install-kittens.bash',
    lazy = false,
    config = function()
        require('smart-splits').setup({
            default_amount = 5,
            at_edge = 'stop',
        })

        -- Navigate splits
        vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
        vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
        vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
        vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
        vim.keymap.set('n', '<C-\\>', require('smart-splits').move_cursor_previous)

        -- Resize splits
        vim.keymap.set('n', '<C-left>', require('smart-splits').resize_left)
        vim.keymap.set('n', '<C-down>', require('smart-splits').resize_down)
        vim.keymap.set('n', '<C-up>', require('smart-splits').resize_up)
        vim.keymap.set('n', '<C-right>', require('smart-splits').resize_right)

        -- Swap splits
        vim.keymap.set('n', '<C-S-left>', require('smart-splits').swap_buf_left)
        vim.keymap.set('n', '<C-S-down>', require('smart-splits').swap_buf_down)
        vim.keymap.set('n', '<C-S-up>', require('smart-splits').swap_buf_up)
        vim.keymap.set('n', '<C-S-right>', require('smart-splits').swap_buf_right)
    end,
}
