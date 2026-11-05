-- Split window
vim.keymap.set('n', '<C-w>-', '<cmd>split<cr>', { desc = 'Split window', silent = true })
vim.keymap.set('n', '<C-w>\\', '<cmd>vsplit<cr>', { desc = 'Split window vertically', silent = true })

-- Navigate splits
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left split' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to lower split' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to upper split' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right split' })
vim.keymap.set('n', '<C-\\>', '<C-w>p', { desc = 'Move to previous split' })

-- Resize splits
local amount = 5
vim.keymap.set('n', '<C-left>', '<cmd>vertical resize -' .. amount .. '<cr>', { desc = 'Decrease split width', silent = true })
vim.keymap.set('n', '<C-right>', '<cmd>vertical resize +' .. amount .. '<cr>', { desc = 'Increase split width', silent = true })
vim.keymap.set('n', '<C-up>', '<cmd>resize +' .. amount .. '<cr>', { desc = 'Increase split height', silent = true })
vim.keymap.set('n', '<C-down>', '<cmd>resize -' .. amount .. '<cr>', { desc = 'Decrease split height', silent = true })

-- Swap splits: exchange the current buffer with the neighbor in a direction
local function swap(dir)
  return function()
    local cur = vim.api.nvim_get_current_win()
    local target = vim.fn.win_getid(vim.fn.winnr(dir))
    if target == cur then return end
    local cur_buf = vim.api.nvim_win_get_buf(cur)
    vim.api.nvim_win_set_buf(cur, vim.api.nvim_win_get_buf(target))
    vim.api.nvim_win_set_buf(target, cur_buf)
    vim.api.nvim_set_current_win(target)
  end
end

vim.keymap.set('n', '<C-S-left>', swap('h'), { desc = 'Swap with left split' })
vim.keymap.set('n', '<C-S-down>', swap('j'), { desc = 'Swap with lower split' })
vim.keymap.set('n', '<C-S-up>', swap('k'), { desc = 'Swap with upper split' })
vim.keymap.set('n', '<C-S-right>', swap('l'), { desc = 'Swap with right split' })
