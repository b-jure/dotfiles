local keymap = vim.keymap.set
local default_ops = { noremap = true, silent = true }
vim.g.tmux_navigator_no_mappings = 1

keymap({ 'n' }, '<M-j>', '<Esc>:TmuxNavigateLeft<CR>', default_ops)
keymap({ 'n' }, '<M-k>', '<Esc>:TmuxNavigateDown<CR>', default_ops)
keymap({ 'n' }, '<M-l>', '<Esc>:TmuxNavigateUp<CR>', default_ops)
keymap({ 'n' }, '<M-h>', '<Esc>:TmuxNavigateRight<CR>', default_ops)
