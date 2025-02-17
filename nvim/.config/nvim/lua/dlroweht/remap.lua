local function map_key(modes, k, v)
    vim.keymap.set(modes, k, v, { noremap = true, silent = true })
end

-- <leader> key
vim.g.mapleader = " "

-- enter command mode but in neovim window
-- WARNING: LSP bugg upon entering the window second time
map_key("n", "<C-f>", ":<C-s>i")

-- resize panes
map_key({ "n", "i" }, "<M-U>", "<Esc>:vertical resize +10<CR>")
map_key({ "n", "i" }, "<M-P>", "<Esc>:vertical resize -10<CR>")
map_key({ "n", "i" }, "<M-O>", "<Esc>:horizontal resize +6<CR>")
map_key({ "n", "i" }, "<M-I>", "<Esc>:horizontal resize -6<CR>")

-- go to next/prev quickfix list item
map_key("n", "[q", "<cmd>cn<CR>")
map_key("n", "]q", "<cmd>cp<CR>")

-- set/unset spelling
map_key("n", "[os", "<cmd>set spell<CR>")
map_key("n", "]os", "<cmd>set nospell<CR>")

-- recenter and invert jumping to misspelled word
map_key("n", "]s", "[szz")
map_key("n", "[s", "]szz")

-- enable/disable syntax highlighting
map_key("n", "[oS", "<cmd>syntax on<CR>")
map_key("n", "]oS", "<cmd>syntax off<CR>")

-- insert space above/below cursor
map_key("n", "<Space>[", "O<Escape>")
map_key("n", "<Space>]", "o<Escape>")

-- indent text without exiting visual mode
map_key("v", "<", "<gv")
map_key("v", ">", ">gv")

-- keep register clean after pasting in visual mode
map_key("v", "p", '"_dP')

-- source
map_key("n", "<leader>vs", "<cmd>so $MYVIMRC<CR>")

-- delete the block
map_key("n", "daf", "da}")

-- movement
map_key({ "n", "v" }, "j", "h")
map_key({ "n", "v" }, "k", "j")
map_key({ "n", "v" }, "l", "k")
map_key({ "n", "v" }, ";", "l")

-- move selected lines up/down
map_key("v", "K", ":m '>+1<CR>gv=gv")
map_key("v", "L", ":m '<-2<CR>gv=gv")

-- move half screen down/up and recenter
map_key("n", "<C-d>", "<C-d>zz")
map_key("n", "<C-u>", "<C-u>zz")

-- move to next/prev match and recenter
map_key("n", "n", "nzz")
map_key("n", "N", "Nzz")

-- delete without polluting primary register
map_key("n", "<leader>d", '"_d')
map_key("v", "<leader>d", '"_d')

-- disable arrow keys
map_key({ "n", "x", "i" }, "<up>", "<nop>")
map_key({ "n", "x", "i" }, "<down>", "<nop>")
map_key({ "n", "x", "i" }, "<left>", "<nop>")
map_key({ "n", "x", "i" }, "<right>", "<nop>")

-- exit
map_key({ "n", "x", "v" }, "q", "<cmd>q<CR>")
map_key("n", "<leader>q", "<cmd>q!<CR>")
map_key("n", "M", "q")

-- no highlight
map_key({ "n", "x", "v" }, "<leader>h", ":noh<CR>")

-- write (save)
map_key("n", "<leader>w", ":w<CR>")

-- Fix * (cursor stays stays on the first match)
map_key("n", "*", "*N")

-- sort
map_key("v", "<C-s>", "<cmd>!sort<CR>")

-- to upper
map_key("n", "<leader>U", "gUiwe")
-- to lower
map_key("n", "<leader>u", "guiwe")

-- remap directional delete
map_key("n", "dl", "dk")
map_key("n", "dk", "dj")

-- swap between 2 most recent buffers
map_key("n", "<leader><leader>", "<C-6>")

-- pane navigation
map_key({ "n", "v", "i" }, "<C-j>", "<Esc><C-w>h")
map_key({ "n", "v", "i" }, "<C-k>", "<Esc><C-w>j")
map_key({ "n", "v", "i" }, "<C-l>", "<Esc><C-w>k")
map_key({ "n", "v", "i" }, "<C-;>", "<Esc><C-w>l")

map_key({ "n", "v" }, "<C-w>j", "<C-w>H")
map_key({ "n", "v" }, "<C-w>k", "<C-w>J")
map_key({ "n", "v" }, "<C-w>l", "<C-w>K")
map_key({ "n", "v" }, "<C-w>;", "<C-w>L")
