local keymap = vim.keymap.set
local default_ops = { noremap = true, silent = true }
vim.g.tmux_navigator_no_mappings = 1

keymap({ 'n' }, '<C-j>', '<Esc>:TmuxNavigateLeft<CR>', default_ops)
keymap({ 'n' }, '<C-k>', '<Esc>:TmuxNavigateDown<CR>', default_ops)
keymap({ 'n' }, '<C-l>', '<Esc>:TmuxNavigateUp<CR>', default_ops)
keymap({ 'n' }, '<C-:>', '<Esc>:TmuxNavigateRight<CR>', default_ops)
