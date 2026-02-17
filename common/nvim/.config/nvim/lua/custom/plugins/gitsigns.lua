---@module "lazy"
---@type LazySpec
return {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    ---@module "gitsigns"
    ---@type Gitsigns.Config|{}
    opts = {
        on_attach = function(bufnr)
            local gitsigns = require('gitsigns')

            -- Navigation
            vim.keymap.set('n', ']c', function()
                if vim.wo.diff then
                    vim.cmd.normal({ ']c', bang = true })
                else
                    gitsigns.nav_hunk('next')
                end
            end, { desc = 'Next change', buffer = bufnr })

            vim.keymap.set('n', '[c', function()
                if vim.wo.diff then
                    vim.cmd.normal({ '[c', bang = true })
                else
                    gitsigns.nav_hunk('prev')
                end
            end, { desc = 'Previous change', buffer = bufnr })

            -- Actions
            vim.keymap.set('n', '<leader>gs', gitsigns.stage_hunk, { desc = 'Stage hunk', buffer = bufnr })
            vim.keymap.set('n', '<leader>gr', gitsigns.reset_hunk, { desc = 'Reset hunk', buffer = bufnr })

            vim.keymap.set(
                'v',
                '<leader>gs',
                function() gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
                { desc = 'Stage hunk', buffer = bufnr }
            )

            vim.keymap.set(
                'v',
                '<leader>gr',
                function() gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
                { desc = 'Reset hunk', buffer = bufnr }
            )

            vim.keymap.set('n', '<leader>gS', gitsigns.stage_buffer, { desc = 'Stage buffer', buffer = bufnr })
            vim.keymap.set('n', '<leader>gR', gitsigns.reset_buffer, { desc = 'Reset buffer', buffer = bufnr })
            vim.keymap.set('n', '<leader>gp', gitsigns.preview_hunk, { desc = 'Preview hunk', buffer = bufnr })
            vim.keymap.set(
                'n',
                '<leader>gi',
                gitsigns.preview_hunk_inline,
                { desc = 'Preview hunk inline', buffer = bufnr }
            )

            vim.keymap.set(
                'n',
                '<leader>gb',
                function() gitsigns.blame_line({ full = true }) end,
                { desc = 'Blame line', buffer = bufnr }
            )

            vim.keymap.set('n', '<leader>gd', gitsigns.diffthis, { desc = 'Diff this', buffer = bufnr })

            vim.keymap.set(
                'n',
                '<leader>gD',
                function() gitsigns.diffthis('~') end,
                { desc = 'Diff this buffer', buffer = bufnr }
            )

            vim.keymap.set(
                'n',
                '<leader>gQ',
                function() gitsigns.setqflist('all') end,
                { desc = 'Set quickfix list all', buffer = bufnr }
            )
            vim.keymap.set('n', '<leader>gq', gitsigns.setqflist, { desc = 'Set quick fix list', buffer = bufnr })

            -- Toggles
            vim.keymap.set(
                'n',
                '<leader>gtb',
                gitsigns.toggle_current_line_blame,
                { desc = 'Toggle current line blame', buffer = bufnr }
            )
            vim.keymap.set('n', '<leader>gtw', gitsigns.toggle_word_diff, { desc = 'Toggle word diff', buffer = bufnr })

            -- Text object
            vim.keymap.set({ 'o', 'x' }, 'ih', gitsigns.select_hunk, { desc = 'Select hunk', buffer = bufnr })
        end,
    },
}
