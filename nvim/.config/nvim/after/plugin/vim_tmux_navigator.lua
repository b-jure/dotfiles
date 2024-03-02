local keymap = vim.keymap.set
local default_ops = { noremap = true, silent = true }
vim.g.tmux_navigator_no_mappings = 1

keymap({ 'n' }, '<M-J>', '<Esc>:TmuxNavigateLeft<CR>', default_ops)
keymap({ 'n' }, '<M-K>', '<Esc>:TmuxNavigateDown<CR>', default_ops)
keymap({ 'n' }, '<M-L>', '<Esc>:TmuxNavigateUp<CR>', default_ops)
keymap({ 'n' }, '<M-H>', '<Esc>:TmuxNavigateRight<CR>', default_ops)
