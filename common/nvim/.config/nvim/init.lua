----------------------------
-- @title: NVIM           --
-- @author: Owen Donckers --
----------------------------

vim.loader.enable()

vim.g.mapleader = ','
vim.g.maplocalleader = '\\'
vim.g.relativenumber = false

-- Basic settings
vim.opt.number = true -- Line numbers
vim.opt.relativenumber = vim.g.relativenumber -- Relative line numbers
vim.opt.cursorline = true -- Highlight current line
vim.opt.cursorlineopt = 'screenline,number' -- Parts to highlight of current line
vim.opt.wrap = false -- Don't wrap lines
vim.opt.scrolloff = 8 -- Keep some lines above/below cursor
vim.opt.sidescrolloff = 5 -- Keep some columns left/right of cursor

-- Indentation
vim.opt.tabstop = 2 -- Tab width
vim.opt.shiftwidth = 2 -- Indent width
vim.opt.softtabstop = 2 -- Soft tab stop
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.smartindent = true -- Smart auto-indenting

-- Search settings
vim.opt.ignorecase = true -- Case insensitive search
vim.opt.smartcase = true -- Case sensitive if uppercase in search

-- Visual settings
vim.opt.showmode = false -- Hide the -- MODE -- text
vim.opt.signcolumn = 'yes' -- Always show sign column
vim.opt.colorcolumn = '140' -- Show column in text
vim.opt.showmatch = true -- Highlight matching brackets
vim.opt.matchtime = 2 -- How long to show matching bracket
vim.opt.pumheight = 10 -- Popup menu height
vim.opt.winborder = 'none' -- Floating window border
vim.opt.synmaxcol = 300 -- Syntax highlighting limit
vim.opt.fillchars = { eob = ' ' } -- Fill characters
vim.opt.breakindent = true -- Wrapped lines will indent visually
vim.opt.linebreak = true -- Wrapped lines will soft break on whitespace

-- Whitespace characters
vim.opt.list = true -- Display whitespace characters
vim.opt.listchars = { -- Whitespace characters definitions
    tab = '» ',
    trail = '·',
    nbsp = '␣',
    -- lead = '·',
}

-- File handling
vim.opt.swapfile = false -- Don't create swap files
vim.opt.undofile = true -- Persistent undo
vim.opt.updatetime = 400 -- Faster completion
vim.opt.timeoutlen = 500 -- Key timeout duration
vim.opt.ttimeoutlen = 0 -- Key code timeout
vim.opt.fileformats = 'unix,dos,mac' -- Match eof formatting to system

-- Persist undo accross processes
local undodir = vim.fn.expand('~/.vim/undodir')
vim.opt.undodir = undodir
if vim.fn.isdirectory(undodir) == 0 then vim.fn.mkdir(undodir, 'p') end

-- Behavior settings
vim.opt.iskeyword:append('-') -- Treat dash as part of word
vim.opt.path:append('**') -- include subdirectories in search
vim.opt.mouse = 'a' -- Enable mouse support
vim.schedule(function() vim.opt.clipboard:append('unnamedplus') end) -- Use system clipboard
vim.opt.inccommand = 'split' -- Preview substitutions
vim.opt.confirm = true -- Confirm dialog for unsaved changes
vim.cmd('syntax sync minlines=256') -- Limit syntax parsing to N amount of lines

-- Folding settings
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevelstart = 99

-- Performance improvements
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

-- Package helpers
local gh = function(x) return 'https://github.com/' .. x end

-- Package spec
vim.pack.add({
    gh('datsfilipe/vesper.nvim'),
    gh('nvim-lualine/lualine.nvim'),
    gh('nvim-treesitter/nvim-treesitter'),
    gh('nvim-mini/mini.icons'),
    gh('folke/which-key.nvim'),
})

-- Pack: Vesper theme
require('vesper').setup({
    transparent = true, -- Boolean: Sets the background to transparent
    italics = {
        comments = true, -- Boolean: Italicizes comments
        keywords = false, -- Boolean: Italicizes keywords
        functions = false, -- Boolean: Italicizes functions
        strings = false, -- Boolean: Italicizes strings
        variables = false, -- Boolean: Italicizes variables
    },
    overrides = {}, -- A dictionary of group names, can be a function returning a dictionary or a table.
    palette_overrides = {},
})
vim.cmd('colorscheme vesper')

-- Pack: Lualine
require('lualine').setup({
    options = {
        icons_enabled = false,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
    },
})

-- Pack: Treesitter
require('nvim-treesitter').setup({
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
})
require('vim.treesitter.query').add_predicate('is-mise?', function(_, _, bufnr, _)
    local filepath = vim.api.nvim_buf_get_name(tonumber(bufnr) or 0)
    local filename = vim.fn.fnamemodify(filepath, ':t')
    return string.match(filename, '.*mise.*%.toml$') ~= nil
end, { force = true, all = false })

-- Pack: Mini icons
require('mini.icons').setup()

-- Pack: Which key
require('which-key').setup({
    preset = 'helix',
    icons = { mappings = false },
    spec = {
        {
            '<leader>b',
            group = 'Buffers',
            expand = function() return require('which-key.extras').expand.buf() end,
        },
        { '<leader>c', group = 'Quickfix list' },
        { '<leader>d', group = 'Diagnostics' },
        { '<leader>g', group = 'Git' },
        { '<leader>gt', group = 'Toggle' },
        { '<leader>h', group = 'Harpoon' },
        { '<leader>n', group = 'No Neck Pain' },
        { '<leader>o', group = 'Obsidian' },
        { '<leader>t', group = 'Test' },
        { '<leader>tr', group = 'Run' },
        { '<leader>w', proxy = '<C-w>', group = 'Windows' },
    },
})
