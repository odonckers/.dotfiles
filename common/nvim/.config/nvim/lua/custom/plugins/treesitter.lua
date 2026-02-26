---@module "lazy"
---@type LazySpec
return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    -- Not sure why there is a difference between macos and linux config plural
    main = vim.loop.os_uname().sysname == 'Linux' and 'nvim-treesitter.config' or 'nvim-treesitter.configs',
    opts = {
        ensure_installed = {
            'angular',
            'bash',
            'c',
            'c_sharp',
            'dockerfile',
            'javascript',
            'kdl',
            'kotlin',
            'lua',
            'markdown',
            'markdown_inline',
            'query',
            'regex',
            'tmux',
            'toml',
            'typescript',
            'vim',
            'vimdoc',
            'xml',
            'yaml',
        },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
    },
    init = function()
        require('vim.treesitter.query').add_predicate('is-mise?', function(_, _, bufnr, _)
            local filepath = vim.api.nvim_buf_get_name(tonumber(bufnr) or 0)
            local filename = vim.fn.fnamemodify(filepath, ':t')
            return string.match(filename, '.*mise.*%.toml$') ~= nil
        end, { force = true, all = false })
    end,
}
