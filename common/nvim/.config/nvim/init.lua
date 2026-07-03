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
vim.opt.scrolloff = 5 -- Keep some lines above/below cursor
vim.opt.sidescrolloff = 3 -- Keep some columns left/right of cursor

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
vim.opt.signcolumn = 'yes' -- Always show sign column
vim.opt.colorcolumn = '140' -- Show column in text
vim.opt.showmatch = true -- Highlight matching brackets
vim.opt.matchtime = 2 -- How long to show matching bracket
vim.opt.pumheight = 10 -- Popup menu height
vim.opt.synmaxcol = 300 -- Syntax highlighting limit
vim.opt.fillchars = { eob = ' ' } -- Fill characters
vim.opt.breakindent = true -- Wrapped lines will indent visually
vim.opt.linebreak = true -- Wrapped lines will soft break on whitespace
vim.opt.splitbelow = true -- Split below and focus below
vim.opt.splitright = true -- Split to the right and focus the right

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
    gh('kepano/flexoki-neovim'),
    gh('arborist-ts/arborist.nvim'),
    gh('nvim-mini/mini.icons'),
    gh('folke/which-key.nvim'),
    gh('nvim-lua/plenary.nvim'),

    -- editing
    gh('nvim-mini/mini.surround'),

    -- filetree
    { src = gh('nvim-neo-tree/neo-tree.nvim'), version = 'v3.x' },
    gh('MunifTanjim/nui.nvim'),

    -- fzf
    gh('ibhagwan/fzf-lua'),

    -- git
    gh('lewis6991/gitsigns.nvim'),

    -- oil
    gh('stevearc/oil.nvim'),

    -- quick-fix
    gh('yorickpeterse/nvim-pqf'),

    -- splits
    gh('mrjones2014/smart-splits.nvim'),

    -- lsp
    gh('neovim/nvim-lspconfig'),

    -- Completion sources
    gh('hrsh7th/cmp-nvim-lsp'),
    gh('hrsh7th/cmp-buffer'),
    gh('hrsh7th/cmp-path'),
    gh('hrsh7th/cmp-cmdline'),
    gh('f3fora/cmp-spell'),
    gh('hrsh7th/nvim-cmp'),

    -- Snippet collections
    gh('rafamadriz/friendly-snippets'),

    -- Language/file support
    gh('folke/lazydev.nvim'), -- lua
    { src = gh('mrcjkb/rustaceanvim'), version = vim.version.range('^7') }, -- rust
    gh('seblyng/roslyn.nvim'),
    gh('antosha417/nvim-lsp-file-operations'),

    -- format
    gh('stevearc/conform.nvim'),

    -- test
    gh('nvim-neotest/neotest'),
    gh('nvim-neotest/nvim-nio'),
    gh('antoinemadec/FixCursorHold.nvim'),
    gh('nvim-neotest/neotest-jest'), -- jest
    gh('nsidorenco/neotest-vstest'), -- dotnet

    -- dap
    gh('mfussenegger/nvim-dap'),
    gh('Weissle/persistent-breakpoints.nvim'),
    gh('igorlfs/nvim-dap-view'),
    gh('theHamsta/nvim-dap-virtual-text'),
})

-- Color scheme
vim.cmd('colorscheme flexoki')

-- Transparent background (must be after color scheme)
-- vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
-- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
-- vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
-- vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'none' })

-- Pack: Arborist
require('arborist').setup({
    prefer_wasm = false,
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
    win = { border = 'none' },
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
