---@module "lazy"
---@type LazySpec
return {
    'mikavilpas/yazi.nvim',
    version = '*', -- use the latest stable version
    event = 'VeryLazy',
    dependencies = {
        { 'nvim-lua/plenary.nvim', lazy = true },
    },
    init = function()
        -- mark netrw as loaded so it's not loaded at all.
        -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
        vim.g.loaded_netrwPlugin = 1
    end,
    ---@module "yazi"
    ---@type YaziConfig | {}
    opts = {
        open_for_directories = true,
        keymaps = {
            show_help = '<f1>',
        },
    },
    keys = {
        {
            '<leader><space>',
            mode = { 'n', 'v' },
            '<cmd>Yazi<cr>',
            desc = 'Open yazi at the current file',
        },
        {
            '<leader>y',
            '<cmd>Yazi cwd<cr>',
            desc = "Open the file manager in nvim's working directory",
        },
    },
}
