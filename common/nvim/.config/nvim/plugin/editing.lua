require('mini.surround').setup()

-- Better J behavior
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join lines and keep cursor position', noremap = true })

-- Better indenting
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right', noremap = true })
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left', noremap = true })

-- Clear search highlights
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<cr>', { silent = true })

-- Go to normal mode (matches <C-\><C-n>, freeing up <C-\> for zmx)
vim.keymap.set({ 'i', 't' }, '<C-Space>', '<C-\\><C-n>', { desc = 'Go to normal mode' })

-- Center screen when jumping
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result (centered)', noremap = true })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result (centered)', noremap = true })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Half page down (centered)' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Half page up (centered)' })
