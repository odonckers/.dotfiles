require('pqf').setup()

vim.keymap.set('n', '<leader>co', '<cmd>copen<cr>', { desc = 'Open', silent = true })
vim.keymap.set('n', '<leader>cc', '<cmd>cclose<cr>', { desc = 'Close', silent = true })
vim.keymap.set('n', '<leader>cr', '<cmd>cexpr []<bar>cclose<cr>', { desc = 'Reset', silent = true })

vim.keymap.set('n', '<leader>dq', function() vim.diagnostic.setqflist() end, { desc = 'Set quickfix list' })
