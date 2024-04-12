-- Wrapper function for vim.keymap.set
local function map_key(modes, k, v)
	vim.keymap.set(modes, k, v, { noremap = true, silent = true })
end

vim.g.mapleader = " "

map_key("n", "L", "<nop>")

map_key("n", "<C-f>", ":<C-s>")

map_key({ "n", "i" }, "<M-U>", "<Esc>:vertical resize +10<CR>") -- make the window bigger vertically
map_key({ "n", "i" }, "<M-P>", "<Esc>:vertical resize -10<CR>") -- make the window smaller vertically
map_key({ "n", "i" }, "<M-O>", "<Esc>:horizontal resize +6<CR>") -- make the window bigger horizontally by pressing shift and =
map_key({ "n", "i" }, "<M-I>", "<Esc>:horizontal resize -6<CR>") -- make the window smaller horizontally by pressing shift and -

map_key("v", "<", "<gv")
map_key("v", ">", ">gv")

map_key("n", "<leader>ar", ":let @a=''<CR>")

map_key("n", "<leader>u", "gU")
map_key("n", "gu", "gUiwe")

map_key("v", "p", '"_dP')

map_key("n", "<leader>vs", ":source $MYVIMRC<CR>")

-- Remap Netrw
-- map_key("n", "<leader>pv", vim.cmd.Ex)

-- Delete the block
map_key("n", "daf", "da}")

-- Movement
map_key({ "n", "v" }, "j", "h")
map_key({ "n", "v" }, "k", "j")
map_key({ "n", "v" }, "l", "k")
map_key({ "n", "v" }, ";", "l")

map_key("v", "K", ":m '>+1<CR>gv=gv")
map_key("v", "L", ":m '<-2<CR>gv=gv")
map_key("n", "<C-d>", "<C-d>zz")
map_key("n", "<C-u>", "<C-u>zz")
map_key("n", "n", "nzz")
map_key("n", "N", "Nzz")
map_key("n", "<leader>y", '"+y')
map_key("v", "<leader>y", '"+y')
map_key("n", "<leader>d", '"_d')
map_key("v", "<leader>d", '"_d')

-- Disable Arrow Keys
map_key({ "n", "x", "i" }, "<up>", "<nop>")
map_key({ "n", "x", "i" }, "<down>", "<nop>")
map_key({ "n", "x", "i" }, "<left>", "<nop>")
map_key({ "n", "x", "i" }, "<right>", "<nop>")

-- Exit window
map_key({ "n", "x", "v" }, "q", ":q<CR>")
map_key("n", "<leader>q", "q!<CR>")
map_key("n", "M", "q")

-- no highlight
map_key({ "n", "x", "v" }, "<leader>h", ":noh<CR>")

-- write (save)
map_key("n", "<leader>w", ":w<CR>")

-- Insert blank line above
map_key("n", "<leader>o", "O<ESC>")

-- Move to the next/previous buffer
map_key("n", "<leader>[", "<CMD>bp<CR>")
map_key("n", "<leader>]", "<CMD>bn<CR>")

map_key("n", "Q", "<nop>")

-- Fix * (cursor stays stays on the first match)
map_key("n", "*", "*N")
