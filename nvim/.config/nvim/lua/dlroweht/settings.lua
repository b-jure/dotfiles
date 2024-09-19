local o = vim.o
local g = vim.g

vim.api.nvim_set_hl(0, "ColorColumn", { fg = "#505050", bg = "#505050" })
vim.opt.colorcolumn = "79"

g.c_syntax_for_h = true
g.c_no_curly_error = true
g.no_man_maps = true

o.termguicolors = true

o.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr-o:hor20,o:hor50,a:blinkon350"

-- Decrease update time
o.updatetime = 50

-- conceal level
o.cole = 2

-- Number of screen lines to keep above and below the cursor
o.scrolloff = 8
-- Better editor UI
o.number = true
o.numberwidth = 5
o.relativenumber = true
o.signcolumn = "number"
o.cursorline = false
o.cursorlineopt = "screenline"

o.cedit = "<C-s>"

-- Better editing experience
o.expandtab = true
-- o.smarttab = true
o.cindent = true
-- o.autoindent = true
o.wrap = false
o.textwidth = 80
vim.opt_local.formatoptions:remove({ "c", "r", "o", "t" })
-- vim.opt.expandtab = true
o.tabstop = 8
o.shiftwidth = 4
o.softtabstop = 4
o.list = false

o.clipboard = "unnamedplus"

o.ignorecase = true
o.smartcase = true

o.backup = false
o.writebackup = false
o.undofile = false
o.swapfile = false
o.undodir = ".vim_undo"

o.history = 100

o.splitright = true
o.splitbelow = true

o.jumpoptions = "view"

o.autochdir = true

g.netrw_special_syntax = true
g.netrw_browse_split = 0
g.netrw_banner = 0
g.netrw_winsize = 25
g.netrw_liststyle = 1


-- Fix Identation of switch statement in c
o.cinoptions = "l1"
