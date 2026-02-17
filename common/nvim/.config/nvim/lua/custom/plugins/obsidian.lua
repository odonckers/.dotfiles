---@module "lazy"
---@type LazySpec
return {
    'obsidian-nvim/obsidian.nvim',
    version = '*', -- use latest release, remove to use latest commit
    dependencies = { 'ibhagwan/fzf-lua' },
    ft = 'markdown',
    cmd = 'Obsidian',
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
        legacy_commands = false, -- this will be removed in the next major release
        workspaces = {
            {
                name = 'OwenOS',
                path = '~/Documents/OwenOS',
            },
        },
        daily_notes = {
            folder = 'Daily Notes',
            template = 'Templates/Daily Note.md',
        },
    },
    keys = {
        -- Top level commands
        { '<leader>oo', '<cmd>Obsidian quick_switch<cr>', desc = 'Quick switch', silent = true },
        { '<leader>on', '<cmd>Obsidian new<cr>', desc = 'New note', silent = true },
        { '<leader>os', '<cmd>Obsidian search<cr>', desc = 'Search notes', silent = true },
        { '<leader>ow', '<cmd>Obsidian workspace<cr>', desc = 'Switch workspaces', silent = true },

        -- Note commands
        { '<leader>ob', '<cmd>Obsidian backlinks<cr>', desc = 'Goto backlinks', silent = true },
        { '<leader>oc', '<cmd>Obsidian toc<cr>', desc = 'Search table of contents for note', silent = true },
        { '<leader>od', '<cmd>Obsidian dailies<cr>', desc = 'Search daily notes', silent = true },
        { '<leader>of', '<cmd>Obsidian follow_link<cr>', desc = 'Follow link under cursor', silent = true },
        { '<leader>oI', '<cmd>Obsidian paste_img<cr>', desc = 'Paste image at cursor', silent = true },
        { '<leader>ol', '<cmd>Obsidian links<cr>', mode = 'n', desc = 'Links in note', silent = true },
        { '<leader>or', '<cmd>Obsidian rename<cr>', desc = 'Rename note or link under cursor', silent = true },
        { '<leader>ot', '<cmd>Obsidian today<cr>', desc = 'Open todays note', silent = true },
        { '<leader>oy', '<cmd>Obsidian yesterday<cr>', desc = 'Open yesterdays note', silent = true },

        -- Visual mode commands
        {
            '<leader>ne',
            '<cmd>Obsidian extract_note<cr>',
            mode = 'v',
            desc = 'Extract selection into new note',
            silent = true,
        },
        {
            '<leader>nl',
            '<cmd>Obsidian link<cr>',
            mode = 'v',
            desc = 'Link selection to an existing note',
            silent = true,
        },
        { '<leader>nL', ':Obsidian link_new ', mode = 'v', desc = 'Link selection to a new note', silent = true },
    },
}
