vim.pack.add({ 'https://github.com/stevearc/conform.nvim' })

require('conform').setup({
    formatters_by_ft = {
        lua = { 'stylua' },
        bash = { 'shfmt' },
        shell = { 'shfmt' },
        sh = { 'shfmt' },
        javascript = { lsp_format = 'prefer' },
        typescript = { lsp_format = 'prefer' },
        go = { 'goimports', 'gofmt' },
    },
    format_on_save = function(bufnr)
        if vim.b.autofmt == false then return end
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        if bufname:match('/node_modules/') then return end
        return { timeout_ms = 1000, lsp_format = 'never' }
    end,
})

vim.keymap.set('n', '<leader>f', function() require('conform').format() end, { desc = 'Format current buffer' })

vim.api.nvim_create_user_command('SetAutoFormat', function()
    vim.b.autofmt = true
    vim.notify('Enabled auto format for this buffer')
end, {})

vim.api.nvim_create_user_command('SetNoAutoFormat', function()
    vim.b.autofmt = false
    vim.notify('Disabled auto format for this buffer')
end, {})
