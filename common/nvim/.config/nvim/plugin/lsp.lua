vim.lsp.enable({
    'clangd', -- brew:llvm
    'lua_ls', -- LuaLS/lua-language-server
    'vtsls', -- npm:@vtsls/language-server
    'angularls', -- npm:@angular/language-server
    'copilot', -- npm:@github/copilot-language-server
    'sourcekit', -- macOS:SourceKit

    -- npm:vscode-langservers-extracted
    'html',
    'cssls',
    'jsonls',
    'eslint',
})

vim.lsp.inlay_hint.enable(true)

vim.diagnostic.config({
    float = {
        border = 'rounded',
        focusable = true,
    },
    virtual_lines = false,
    virtual_text = {
        current_line = true,
        severity = { min = vim.diagnostic.severity.WARN },
    },
    underline = {
        severity = { min = vim.diagnostic.severity.WARN },
    },
})

-- Set virtual lines
vim.api.nvim_create_user_command('SetVirtualLines', function()
    vim.diagnostic.config({
        virtual_lines = { current_line = true },
        virtual_text = false,
    })
    vim.notify('Enabled LSP virtual lines ')
end, {})

vim.api.nvim_create_user_command('SetNoVirtualLines', function()
    vim.diagnostic.config({
        virtual_lines = false,
        virtual_text = { current_line = true },
    })
    vim.notify('Disabled LSP virtual lines')
end, {})

-- Set inlay hints
vim.api.nvim_create_user_command('SetInlayHints', function()
    vim.lsp.inlay_hint.enable(true)
    vim.notify('Enabled LSP inlay hints')
end, {})

vim.api.nvim_create_user_command('SetNoInlayHints', function()
    vim.lsp.inlay_hint.enable(false)
    vim.notify('Disabled LSP inlay hints')
end, {})
