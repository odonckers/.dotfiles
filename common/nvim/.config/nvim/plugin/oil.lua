require('oil').setup({
    keymaps = {
        ['<C-h>'] = false,
        ['<C-l>'] = false,
    },
    use_default_keymaps = true,
    view_options = {
        show_hidden = true,
    },
})

vim.keymap.set('n', '<leader><space>', '<cmd>Oil<cr>', { desc = 'Open oil' })
