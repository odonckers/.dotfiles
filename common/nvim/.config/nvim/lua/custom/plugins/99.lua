---@module "lazy"
---@type LazySpec
return {
    'ThePrimeagen/99',
    opts = {
        completion = { source = 'cmp' },
        md_files = { 'AGENT.md' },
    },
    keys = {
        { '<leader>9v', function() require('99').visual() end, mode = 'v' },
        { '<leader>9s', function() require('99').stop_all_requests() end, mode = { 'n', 'v' } },
    },
}
