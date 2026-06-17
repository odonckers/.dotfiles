local gh = function(x) return 'https://github.com/' .. x end

vim.pack.add({
    gh('nvim-lua/plenary.nvim'),

    -- LSP
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
    -- gh('GustavEikaas/easy-dotnet.nvim'), -- c# / dotnet
    gh('fladson/vim-kitty'), -- kitty config
    gh('antosha417/nvim-lsp-file-operations'),
})

vim.lsp.inlay_hint.enable(true)

vim.diagnostic.config({
    float = {
        border = 'rounded',
        focusable = true,
    },
    virtual_lines = false,
    virtual_text = {
        current_line = true,
        severity = { min = vim.diagnostic.severity.WARN },
    },
    underline = {
        severity = { min = vim.diagnostic.severity.WARN },
    },
})

-- Pack: LSP File Operations
require('lsp-file-operations').setup()

-- Setup completion
local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args) vim.snippet.expand(args.body) end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'lazydev', group_index = 0 },
        -- { name = 'easy-dotnet', group_index = 0 },
        { name = 'path' },
        { name = 'buffer' },
        { name = 'spell' },
    }),
})

-- Use buffer source for `/` and `?` (if you enabled `view.entries = 'native'`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' },
    },
})

-- Use cmdline & path source for ':' (if you enabled `view.entries = 'native'`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' },
    }, {
        { name = 'cmdline' },
    }),
})

-- Enable LSPs
vim.lsp.enable({
    'clangd', -- brew:llvm
    'lua_ls', -- LuaLS/lua-language-server
    'vtsls', -- npm:@vtsls/language-server
    'angularls', -- npm:@angular/language-server
    'copilot', -- npm:@github/copilot-language-server
    'sourcekit', -- macOS:SourceKit
    'roslyn', -- seblyng/roslyn.nvim

    -- npm:vscode-langservers-extracted
    'html',
    'cssls',
    'jsonls',
    'eslint',
})

-- Setup LSP capabilities for CMP
local capabilities = vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    require('cmp_nvim_lsp').default_capabilities()
)
vim.lsp.config('*', { capabilities = capabilities })

-- Pack: Easy Dotnet
-- Requires `dotnet tool install -g EasyDotnet`
-- local easy_dotnet = require('easy-dotnet')
-- easy_dotnet.setup({
--     lsp = {
--         enabled = true,
--         config = {
--             settings = {
--                 ['csharp|symbol_search'] = {
--                     dotnet_search_reference_assemblies = true,
--                 },
--                 ['csharp|completion'] = {
--                     dotnet_show_name_completion_suggestions = true,
--                     dotnet_provide_regex_completions = true,
--                     dotnet_show_completion_items_from_unimported_namespaces = true,
--                 },
--                 ['csharp|quick_info'] = {
--                     dotnet_show_remarks_in_quick_info = true,
--                 },
--                 ['navigation'] = {
--                     dotnet_navigate_to_decompiled_sources = true,
--                 },
--                 ['csharp|highlighting'] = {
--                     dotnet_highlight_related_regex_components = true,
--                     dotnet_highlight_related_json_components = true,
--                 },
--                 ['csharp|inlay_hints'] = {
--                     dotnet_enable_inlay_hints_for_parameters = true,
--                     dotnet_enable_inlay_hints_for_literal_parameters = true,
--                     dotnet_enable_inlay_hints_for_indexer_parameters = false,
--                     dotnet_enable_inlay_hints_for_object_creation_parameters = true,
--                     dotnet_enable_inlay_hints_for_other_parameters = true,
--                     dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
--                     dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
--                     dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
--                     csharp_enable_inlay_hints_for_types = false,
--                     csharp_enable_inlay_hints_for_implicit_variable_types = false,
--                     csharp_enable_inlay_hints_for_lambda_parameter_types = false,
--                     csharp_enable_inlay_hints_for_implicit_object_creation = false,
--                 },
--                 ['csharp|background_analysis'] = {
--                     dotnet_analyzer_diagnostics_scope = 'fullSolution',
--                     dotnet_compiler_diagnostics_scope = 'fullSolution',
--                 },
--                 ['csharp|code_lens'] = {
--                     dotnet_enable_references_code_lens = true,
--                     dotnet_enable_tests_code_lens = true,
--                 },
--                 ['csharp|auto_insert'] = {
--                     dotnet_enable_auto_insert = true,
--                 },
--                 ['csharp|formatting'] = {
--                     dotnet_organize_imports_on_format = true,
--                 },
--             },
--         },
--         debugger = { bin_path = vim.env.XDG_DATA_HOME .. '/netcoredbg/bin/netcoredbg' },
--     },
-- })
-- cmp.register_source('easy-dotnet', easy_dotnet.package_completion_source)
vim.lsp.config('roslyn', {
    settings = {
        ['csharp|symbol_search'] = {
            dotnet_search_reference_assemblies = true,
        },
        ['csharp|completion'] = {
            dotnet_show_name_completion_suggestions = true,
            dotnet_provide_regex_completions = true,
            dotnet_show_completion_items_from_unimported_namespaces = true,
        },
        ['csharp|quick_info'] = {
            dotnet_show_remarks_in_quick_info = true,
        },
        ['navigation'] = {
            dotnet_navigate_to_decompiled_sources = true,
        },
        ['csharp|highlighting'] = {
            dotnet_highlight_related_regex_components = true,
            dotnet_highlight_related_json_components = true,
        },
        ['csharp|inlay_hints'] = {
            dotnet_enable_inlay_hints_for_parameters = true,
            dotnet_enable_inlay_hints_for_literal_parameters = true,
            dotnet_enable_inlay_hints_for_indexer_parameters = false,
            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
            dotnet_enable_inlay_hints_for_other_parameters = true,
            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
            csharp_enable_inlay_hints_for_types = false,
            csharp_enable_inlay_hints_for_implicit_variable_types = false,
            csharp_enable_inlay_hints_for_lambda_parameter_types = false,
            csharp_enable_inlay_hints_for_implicit_object_creation = false,
        },
        ['csharp|background_analysis'] = {
            dotnet_analyzer_diagnostics_scope = 'fullSolution',
            dotnet_compiler_diagnostics_scope = 'fullSolution',
        },
        ['csharp|code_lens'] = {
            dotnet_enable_references_code_lens = true,
            dotnet_enable_tests_code_lens = true,
        },
        ['csharp|auto_insert'] = {
            dotnet_enable_auto_insert = true,
        },
        ['csharp|formatting'] = {
            dotnet_organize_imports_on_format = true,
        },
    },
})

-- Set virtual lines
vim.api.nvim_create_user_command('SetVirtualLines', function()
    vim.diagnostic.config({
        virtual_lines = { current_line = true },
        virtual_text = false,
    })
    vim.notify('Enabled LSP virtual lines ')
end, {})

vim.api.nvim_create_user_command('SetNoVirtualLines', function()
    vim.diagnostic.config({
        virtual_lines = false,
        virtual_text = { current_line = true },
    })
    vim.notify('Disabled LSP virtual lines')
end, {})

-- Set inlay hints
vim.api.nvim_create_user_command('SetInlayHints', function()
    vim.lsp.inlay_hint.enable(true)
    vim.notify('Enabled LSP inlay hints')
end, {})

vim.api.nvim_create_user_command('SetNoInlayHints', function()
    vim.lsp.inlay_hint.enable(false)
    vim.notify('Disabled LSP inlay hints')
end, {})

-- Disable builtin completion keys for nvim-cmp
vim.keymap.set({ 'i', 's' }, '<C-p>', '<nop>')
vim.keymap.set({ 'i', 's' }, '<C-n>', '<nop>')

-- Bordered hover
vim.keymap.set('n', 'K', function() vim.lsp.buf.hover({ border = 'rounded' }) end, { desc = 'Hover' })
