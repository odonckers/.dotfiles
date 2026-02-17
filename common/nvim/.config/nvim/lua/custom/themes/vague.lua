---@module "lazy"
---@type LazySpec
return {
    'vague-theme/vague.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other plugins
    ---@module "vague"
    ---@type VagueColorscheme.Config
    opts = {
        style = {
            -- "none" is the same thing as default. But "italic" and "bold" are also valid options
            boolean = 'bold',
            number = 'none',
            float = 'none',
            error = 'bold',
            comments = 'italic',
            conditionals = 'none',
            functions = 'none',
            headings = 'bold',
            operators = 'none',
            strings = 'none',
            variables = 'none',

            -- keywords
            keywords = 'none',
            keyword_return = 'italic',
            keywords_loop = 'none',
            keywords_label = 'none',
            keywords_exception = 'bold',

            -- builtin
            builtin_constants = 'bold',
            builtin_functions = 'none',
            builtin_types = 'bold',
            builtin_variables = 'none',
        },
        plugins = {
            lsp = {
                diagnostic_error = 'bold',
                diagnostic_hint = 'none',
                diagnostic_info = 'none',
                diagnostic_ok = 'none',
                diagnostic_warn = 'bold',
            },
        },
    },
    config = function(_, opts)
        require('vague').setup(opts)
        vim.cmd('colorscheme vague')
    end,
}
