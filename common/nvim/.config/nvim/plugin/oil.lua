vim.pack.add({ 'https://github.com/stevearc/oil.nvim' })

require('oil').setup({
    keymaps = {
        ['<C-h>'] = false,
        ['<C-l>'] = false,
    },
    use_default_keymaps = true,
})

vim.keymap.set('n', '<leader><space>', '<cmd>Oil<cr>', { desc = 'Open oil' })
