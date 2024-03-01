-- Wrapper function for vim.keymap.set
local function map_key(modes, k, v)
    vim.keymap.set(modes, k, v, { noremap = true, silent = true })
end

vim.g.mapleader = ' '

map_key('n', '<leader>ar', ":let @a=''<CR>")
map_key('n', '<leader>f', ":Format<CR>")

-- Use h or ' to hop to marks
map_key('n', 'h', '\'')

map_key('n', '<leader>u', 'gU')
map_key('n', 'gu', 'gUiwe')

map_key('v', 'p', '"_dP');

map_key("n", "<C-k>", "<cmd>cnext<CR>zz")
map_key("n", "<C-l>", "<cmd>cprev<CR>zz")

map_key('n', '<leader>vs', ':source $MYVIMRC<CR>')

-- Remap Netrw
map_key('n', '<leader>pv', vim.cmd.Ex)

-- Delete the block
map_key('n', 'daf', 'da}');

map_key({ 'n', 'v' }, 'j', 'h')
map_key({ 'n', 'v' }, 'k', 'j')
map_key({ 'n', 'v' }, 'l', 'k')
map_key({ 'n', 'v' }, ';', 'l')

map_key("v", "K", ":m '>+1<CR>gv=gv")
map_key("v", "L", ":m '<-2<CR>gv=gv")
map_key("n", "<C-d>", "<C-d>zz")
map_key("n", "<C-u>", "<C-u>zz")
map_key("n", "n", "nzz")
map_key("n", "N", "Nzz")
map_key("n", "<leader>y", "\"+y")
map_key("v", "<leader>y", "\"+y")
map_key("n", "<leader>d", "\"_d")
map_key("v", "<leader>d", "\"_d")

-- Make a file executable
map_key("n", "<leader>mx", "<cmd>!chmod +x %<CR>")

-- Disable Arrow Keys
map_key({ 'n', 'x', 'i' }, '<up>', '<nop>')
map_key({ 'n', 'x', 'i' }, '<down>', '<nop>')
map_key({ 'n', 'x', 'i' }, '<left>', '<nop>')
map_key({ 'n', 'x', 'i' }, '<right>', '<nop>')

-- Exit window
map_key({ 'n', 'x', 'v' }, "<leader>q", ':q!<CR>')

-- Delete buffer
map_key('n', "<leader>x", ":bd<CR>")

-- no highlight
map_key({ 'n', 'x', 'v' }, "<leader>h", ':noh<CR>')

map_key('n', '<leader>w', ':w<CR>')

-- Insert blank line above
map_key('n', '<leader>o', 'O<ESC>')

-- Move to the next/previous buffer
map_key('n', "<leader>[", '<CMD>bp<CR>')
map_key('n', "<leader>]", '<CMD>bn<CR>')

map_key('n', "Q", "<nop>")

-- Fix * (cursor stays stays on the first match)
map_key('n', '*', '*N')
