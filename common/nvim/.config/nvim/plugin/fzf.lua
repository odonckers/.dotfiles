vim.pack.add({ 'https://github.com/ibhagwan/fzf-lua' })

require('fzf-lua').setup({
    'default',
    winopts = {
        backdrop = 100,
    },
    previewers = {
        builtin = {
            syntax_limit_b = 1024 * 100, -- 100KB
        },
    },
    oldfiles = { include_current_session = true },
    grep = {
        rg_glob = true, -- enable glob parsing
        glob_flag = '--iglob', -- case insensitive globs
        glob_separator = '%s%-%-', -- query separator pattern (lua): ' --'
    },
})

vim.keymap.set('n', '<leader><leader>', '<cmd>FzfLua files<cr>', { desc = 'Search files names', silent = true })
vim.keymap.set('n', '<leader>/', '<cmd>FzfLua live_grep<cr>', { desc = 'Search file contents', silent = true })
vim.keymap.set('n', '<leader>`', '<cmd>FzfLua marks<cr>', { desc = 'Search marks', silent = true })
vim.keymap.set('n', '<leader>e', '<cmd>FzfLua oldfiles<cr>', { desc = 'Search old files', silent = true })
vim.keymap.set('n', '<leader>r', '<cmd>FzfLua resume<cr>', { desc = 'Resume last open FZF', silent = true })
vim.keymap.set('n', '<leader>bb', '<cmd>FzfLua buffers<cr>', { desc = 'Search open buffers', silent = true })
