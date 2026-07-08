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

vim.keymap.set('n', '<leader>db', function() require('dap').toggle_breakpoint() end, { desc = '● Toggle breakpoint' })

vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end, { desc = '⏵ Continue' })
vim.keymap.set('n', '<leader>dr', function() require('dap').run_last() end, { desc = '⤷ Run last' })
vim.keymap.set('n', '<leader>dt', function() require('dap').terminate() end, { desc = '⏹ Terminate' })

vim.keymap.set('n', '<leader>dj', function() require('dap').step_over() end, { desc = '↓ Step over' })
vim.keymap.set('n', '<leader>di', function() require('dap').step_into() end, { desc = '→ Step into' })
vim.keymap.set('n', '<leader>do', function() require('dap').step_out() end, { desc = '← Step out' })

vim.keymap.set('n', '<leader>dk', function() require('dap.ui.widgets').hover() end, { desc = '❏ Hover' })

vim.keymap.set('n', '<leader>dd', function() require('dap-view').toggle() end, { desc = '⬓ Toggle DAP view' })
