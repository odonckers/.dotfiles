----------------------------
-- @title: NVIM           --
-- @author: Owen Donckers --
----------------------------

vim.loader.enable()

-- Leaders (set before any plugin/mapping loads so they bind correctly)
vim.g.mapleader = ','
vim.g.maplocalleader = '\\'

-- UI & appearance ------------------------------------------------------------
vim.opt.number = true -- Absolute line numbers
vim.g.relativenumber = false -- Tracked as a global so insert mode can toggle it (see relative-numbers.lua)
vim.opt.relativenumber = vim.g.relativenumber
vim.opt.cursorline = true -- Highlight the current line
vim.opt.cursorlineopt = 'screenline,number' -- ...but only the number + screen line, not the whole row
vim.opt.signcolumn = 'yes' -- Always reserve the sign column so text doesn't shift
vim.opt.colorcolumn = '140' -- Visual guide for max line length
vim.opt.pumheight = 10 -- Cap the completion popup height
vim.opt.winborder = 'rounded' -- Rounded borders on all floating windows (hover, signature, diagnostics)
vim.opt.laststatus = 3 -- Single global statusline shared across all splits
vim.opt.fillchars = { eob = ' ' } -- Hide the ~ on empty lines past the buffer end
vim.opt.showmatch = true -- Briefly jump to the matching bracket on insert
vim.opt.matchtime = 2 -- ...for 200ms

-- Scrolling & wrapping -------------------------------------------------------
vim.opt.wrap = false -- Don't soft-wrap long lines
vim.opt.linebreak = true -- If wrap is ever on, break at word boundaries
vim.opt.breakindent = true -- ...and keep wrapped lines visually indented
vim.opt.scrolloff = 5 -- Keep 5 lines of context above/below the cursor
vim.opt.sidescrolloff = 3 -- Keep 3 columns of context left/right

-- Indentation (2-space soft tabs) --------------------------------------------
vim.opt.expandtab = true -- Insert spaces instead of tabs
vim.opt.tabstop = 2 -- A tab renders as 2 columns
vim.opt.shiftwidth = 2 -- Indent/dedent by 2
vim.opt.softtabstop = -1 -- Tab/backspace follows shiftwidth (so per-filetype overrides only need shiftwidth)
vim.opt.smartindent = true -- Language-aware auto-indent

-- Search ---------------------------------------------------------------------
vim.opt.ignorecase = true -- Case-insensitive by default...
vim.opt.smartcase = true -- ...unless the query contains an uppercase letter
vim.opt.inccommand = 'split' -- Live preview of :substitute in a split

-- Splits & windows -----------------------------------------------------------
vim.opt.splitbelow = true -- Horizontal splits open below
vim.opt.splitright = true -- Vertical splits open to the right
vim.opt.splitkeep = 'screen' -- Keep text visually stable when splits open/close

-- Whitespace rendering -------------------------------------------------------
vim.opt.list = true -- Show invisible characters
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Folding (treesitter-driven, everything open by default) ---------------------
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevelstart = 99

-- Files, undo & clipboard ----------------------------------------------------
vim.opt.swapfile = false -- No swap files
vim.opt.undofile = true -- Persist undo history across sessions
vim.opt.undodir = vim.fn.expand('~/.vim/undodir')
vim.opt.fileformats = 'unix,dos,mac' -- Prefer LF, fall back to CRLF/CR
vim.opt.confirm = true -- Prompt to save instead of failing on unsaved changes
vim.opt.mouse = 'a' -- Mouse support in all modes
vim.opt.jumpoptions = 'stack,view' -- Browser-like jumplist + restore the view on jumps
vim.schedule(function() vim.opt.clipboard:append('unnamedplus') end) -- Share the system clipboard (deferred for faster startup)
if vim.fn.isdirectory(vim.o.undodir) == 0 then vim.fn.mkdir(vim.o.undodir, 'p') end

-- Timing ---------------------------------------------------------------------
vim.opt.updatetime = 400 -- Faster CursorHold events & swap writes (ms)
vim.opt.timeoutlen = 500 -- Time allowed to finish a mapped sequence (ms)
vim.opt.ttimeoutlen = 0 -- No wait on raw terminal key codes

-- Editing behavior -----------------------------------------------------------
vim.opt.iskeyword:append('-') -- Treat foo-bar as a single word
vim.opt.path:append('**') -- :find searches subdirectories recursively

-- Performance (guard the legacy syntax engine; treesitter does the rest) ------
vim.opt.synmaxcol = 300 -- Stop syntax highlighting past column 300
vim.opt.redrawtime = 10000 -- Allow slow files more time before disabling highlight
vim.opt.maxmempattern = 20000 -- Memory ceiling for pattern matching (KB)
vim.cmd('syntax sync minlines=256') -- Limit syntax look-behind for large files

-- Package helpers
local gh = function(x) return 'https://github.com/' .. x end

-- Package spec
vim.pack.add({
    gh('rose-pine/neovim'),
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
require('rose-pine').setup({
    styles = { italic = false },
})
vim.cmd('colorscheme rose-pine')

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
        { '<leader>t', group = 'Test' },
        { '<leader>tr', group = 'Run' },
        { '<leader>w', proxy = '<C-w>', group = 'Windows' },
    },
})
