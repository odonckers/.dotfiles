----------------------------
-- @title: NVIM           --
-- @author: Owen Donckers --
----------------------------

vim.g.mapleader = ','
vim.g.maplocalleader = '\\'
vim.g.relativenumber = true

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
vim.opt.winborder = 'rounded' -- Floating window border
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
    lead = '·',
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

-- Download lazy and append to path
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
---@diagnostic disable-next-line: undefined-field
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
            { out, 'WarningMsg' },
            { '\nPress any key to exit...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Set up lazy and load plugins
require('lazy').setup({
    spec = {
        { import = 'custom/themes' },
        { import = 'custom/plugins' },
    },
    ui = { border = 'rounded' },
    change_detection = { notify = false },
})
