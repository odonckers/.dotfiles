vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2

vim.opt_local.colorcolumn = '140'

vim.lsp.enable({
    'vtsls', -- npm @vtsls/language-server
    'angularls', -- npm @angular/language-server
    'eslint', -- npm vscode-langservers-extracted
})
