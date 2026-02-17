---@module "lazy"
---@type LazySpec
return {
    'shortcuts/no-neck-pain.nvim',
    version = '*',
    opts = {
        width = 'colorcolumn',
        mappings = { enabled = true },
        buffers = {
            right = { enabled = false },
        },
    },
}
