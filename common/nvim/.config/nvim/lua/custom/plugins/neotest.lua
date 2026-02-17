---@module "lazy"
---@type LazySpec
return {
    'nvim-neotest/neotest',
    dependencies = {
        'nvim-neotest/nvim-nio',
        'nvim-lua/plenary.nvim',
        'antoinemadec/FixCursorHold.nvim',
        'nvim-treesitter/nvim-treesitter',

        -- Language support
        'nvim-neotest/neotest-jest', -- jest
        'nsidorenco/neotest-vstest', -- dotnet
    },
    config = function()
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
    end,
    keys = {
        -- Run
        { '<leader>trr', function() require('neotest').run.run() end, desc = 'Run the nearest test' },
        { '<leader>trf', function() require('neotest').run.run(vim.fn.expand('%')) end, desc = 'Run the current file' },
        {
            '<leader>trd',
            function() require('neotest').run.run({ strategy = 'dap' }) end,
            desc = 'Debug the nearest test',
        },
        { '<leader>trs', function() require('neotest').run.stop() end, desc = 'Stop the nearest test' },
        { '<leader>tra', function() require('neotest').run.attach() end, desc = 'Attach to the nearest test' },

        -- Consumers
        { '<leader>tw', function() require('neotest').watch() end, desc = 'Watch files related to tests' },
        {
            '<leader>to',
            function() require('neotest').output.open() end,
            desc = 'Open output window of nearest test',
        },
        { '<leader>tp', function() require('neotest').output_panel.toggle() end, desc = 'Toggle ouput panel' },
        {
            '<leader>ts',
            function() require('neotest').summary.toggle() end,
            desc = 'Open summary panel of project tests',
        },
    },
}
