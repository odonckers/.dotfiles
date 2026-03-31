vim.pack.add({ 'https://github.com/mikavilpas/yazi.nvim' })

-- mark netrw as loaded so it's not loaded at all.
-- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
vim.g.loaded_netrwPlugin = 1

require('yazi').setup({
    open_for_directories = true,
    keymaps = {
        show_help = '<f1>',
    },
})

vim.keymap.set({ 'n', 'v' }, '<leader><space>', '<cmd>Yazi<cr>', { desc = 'Open yazi at the current file' })
vim.keymap.set('n', '<leader>y', '<cmd>Yazi cwd<cr>', { desc = "Open the file manager in nvim's working directory" })
