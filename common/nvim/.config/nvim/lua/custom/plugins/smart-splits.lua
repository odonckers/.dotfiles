return {
    'mrjones2014/smart-splits.nvim',
    lazy = false,
    opts = {
        default_amount = 5,
    },
    keys = {
        -- Navigate splits
        { '<C-h>', function() require('smart-splits').move_cursor_left() end, desc = 'Navigate left' },
        { '<C-l>', function() require('smart-splits').move_cursor_right() end, desc = 'Navigate right' },
        { '<C-j>', function() require('smart-splits').move_cursor_down() end, desc = 'Navigate down' },
        { '<C-k>', function() require('smart-splits').move_cursor_up() end, desc = 'Navigate up' },
        { '<C-\\>', function() require('smart-splits').move_cursor_previous() end, desc = 'Navigate to previous' },

        -- Resize splits
        { '<C-left>', function() require('smart-splits').resize_left() end, desc = 'Resize left' },
        { '<C-right>', function() require('smart-splits').resize_right() end, desc = 'Resize right' },
        { '<C-down>', function() require('smart-splits').resize_down() end, desc = 'Resize down' },
        { '<C-up>', function() require('smart-splits').resize_up() end, desc = 'Resize up' },

        -- Swap splits
        { '<C-S-left>', function() require('smart-splits').swap_buf_left() end, desc = 'Swap buffer left' },
        { '<C-S-right>', function() require('smart-splits').swap_buf_right() end, desc = 'Swap buffer right' },
        { '<C-S-down>', function() require('smart-splits').swap_buf_down() end, desc = 'Swap buffer down' },
        { '<C-S-up>', function() require('smart-splits').swap_buf_up() end, desc = 'Swap buffer up' },
    },
}
