local gh = function(x) return 'https://github.com/' .. x end

vim.pack.add({
    gh('nvim-neotest/neotest'),
    gh('nvim-neotest/nvim-nio'),
    gh('antoinemadec/FixCursorHold.nvim'),

    -- Language support
    gh('nvim-neotest/neotest-jest'), -- jest
    gh('nsidorenco/neotest-vstest'), -- dotnet
})

require('neotest').setup({
    adapters = {
        require('neotest-jest')({
            jestConfigFile = 'jest.config.ts',
            cwd = function(path)
                local current_dir = vim.fn.fnamemodify(path, ':h')
                local jest_config = vim.fn.findfile('jest.config.ts', current_dir .. ';')
                if jest_config ~= '' then return vim.fn.fnamemodify(jest_config, ':h') end
                return vim.fn.getcwd()
            end,
        }),
        require('neotest-vstest'),
    },
})

-- Run
vim.keymap.set('n', '<leader>trr', function() require('neotest').run.run() end, { desc = 'Run the nearest test' })
vim.keymap.set(
    'n',
    '<leader>trf',
    function() require('neotest').run.run(vim.fn.expand('%')) end,
    { desc = 'Run the current file' }
)
vim.keymap.set(
    'n',
    '<leader>trd',
    function() require('neotest').run.run({ strategy = 'dap' }) end,
    { desc = 'Debug the nearest test' }
)
vim.keymap.set('n', '<leader>trs', function() require('neotest').run.stop() end, { desc = 'Stop the nearest test' })
vim.keymap.set(
    'n',
    '<leader>tra',
    function() require('neotest').run.attach() end,
    { desc = 'Attach to the nearest test' }
)

-- Consumers
vim.keymap.set('n', '<leader>tw', function() require('neotest').watch() end, { desc = 'Watch files related to tests' })
vim.keymap.set(
    'n',
    '<leader>to',
    function() require('neotest').output.open() end,
    { desc = 'Open output window of nearest test' }
)
vim.keymap.set(
    'n',
    '<leader>tp',
    function() require('neotest').output_panel.toggle() end,
    { desc = 'Toggle ouput panel' }
)
vim.keymap.set(
    'n',
    '<leader>ts',
    function() require('neotest').summary.toggle() end,
    { desc = 'Open summary panel of project tests' }
)
