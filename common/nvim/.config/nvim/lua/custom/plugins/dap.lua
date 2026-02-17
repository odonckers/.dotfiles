---@module "lazy"
---@type LazySpec
return {
    'mfussenegger/nvim-dap',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'Weissle/persistent-breakpoints.nvim',
        'igorlfs/nvim-dap-view',
        { 'theHamsta/nvim-dap-virtual-text', dependencies = { 'nvim-treesitter/nvim-treesitter' } },
    },
    config = function()
        local dap = require('dap')
        require('persistent-breakpoints').setup({})
        require('dap-view').setup()
        require('nvim-dap-virtual-text').setup({})

        vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint' })
        vim.fn.sign_define('DapBreakpointCondition', { text = '◆', texthl = 'DapBreakpointCondition' })
        vim.fn.sign_define('DapBreakpointRejected', { text = '○', texthl = 'DapBreakpointRejected' })
        vim.fn.sign_define('DapLogPoint', { text = '◎', texthl = 'DapLogPoint' })
        vim.fn.sign_define('DapStopped', {
            text = '→',
            texthl = 'DapStopped',
            linehl = 'DapStoppedLine',
            numhl = 'DapStopped',
        })

        vim.api.nvim_set_hl(0, 'DapBreakpoint', { link = 'ErrorMsg' })
        vim.api.nvim_set_hl(0, 'DapBreakpointCondition', { link = 'ErrorMsg' })
        vim.api.nvim_set_hl(0, 'DapBreakpointRejected', { link = 'ErrorMsg' })
        vim.api.nvim_set_hl(0, 'DapLogPoint', { link = 'ErrorMsg' })
        vim.api.nvim_set_hl(0, 'DapStopped', { link = 'ErrorMsg' })
        vim.api.nvim_set_hl(0, 'DapStoppedLine', { link = 'Visual' })

        dap.listeners.before.attach.dapui_config = function() require('dap-view').open() end
        dap.listeners.before.launch.dapui_config = function() require('dap-view').open() end
        dap.listeners.before.event_terminated.dapui_config = function() require('dap-view').close() end
        dap.listeners.before.event_exited.dapui_config = function() require('dap-view').close() end
    end,
    keys = {
        { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = '● Toggle breakpoint' },

        { '<leader>dc', function() require('dap').continue() end, desc = '⏵ Continue' },
        { '<leader>dr', function() require('dap').run_last() end, desc = '⤷ Run last' },
        { '<leader>dt', function() require('dap').terminate() end, desc = '⏹ Terminate' },

        { '<leader>dj', function() require('dap').step_over() end, desc = '↓ Step over' },
        { '<leader>di', function() require('dap').step_into() end, desc = '→ Step into' },
        { '<leader>do', function() require('dap').step_out() end, desc = '← Step out' },

        { '<leader>dk', function() require('dap.ui.widgets').hover() end, desc = '❏ Hover' },

        { '<leader>dd', function() require('dap-view').toggle() end, desc = '⬓ Toggle DAP view' },
    },
}
