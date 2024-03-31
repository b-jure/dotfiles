local opt = { silent = true }
vim.keymap.set('n', '<leader>gs', ':Git<CR>', opt)
vim.keymap.set('n', '<leader>gc', ':Git commit<CR>', opt)
vim.keymap.set('n', '<leader>gd', ':Git diff<CR>', opt)
vim.keymap.set('n', '<leader>gp', ':Git push<CR>', opt)
vim.keymap.set('n', '<leader>gb', ':Git checkout ', opt)
vim.keymap.set('n', '<leader>gnb', ':Git branch ', opt)
