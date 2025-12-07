local o = vim.o
local g = vim.g

vim.api.nvim_set_hl(0, "ColorColumn", { fg = "#505050", bg = "#505050" })
vim.opt.colorcolumn = "79"

g.c_syntax_for_h = true
g.c_no_curly_error = true
g.no_man_maps = true
o.termguicolors = true
o.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr-o:hor20,o:hor50,a:blinkon350"
o.updatetime = 50
o.cole = 2
o.scrolloff = 8
o.number = true
o.numberwidth = 5
o.relativenumber = true
o.signcolumn = "number"
o.cursorline = false
o.cursorlineopt = "screenline"
o.cedit = "<C-s>"
o.cursorline = true

-- indentation
o.cindent = true
o.cinkeys = "0{,0},0),0],:,!^F,o,O,e"
o.indentkeys = "0{,0},0),0],:,!^F,o,O,e"
o.cinoptions = "l1,W2,#0"
o.autoindent = false

-- tabs/look
o.wrap = true
o.textwidth = 80
o.expandtab = true
o.tabstop = 8
o.shiftwidth = 4
o.softtabstop = 4

o.list = false
o.clipboard = "unnamedplus,unnamed"
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
o.autochdir = false
g.netrw_special_syntax = true
g.netrw_browse_split = 0
g.netrw_banner = 0
g.netrw_winsize = 25
g.netrw_liststyle = 1
g.title = true
o.termsync = true
o.signcolumn = "auto"
o.errorformat = "%f:%l: %m"
o.makeprg = "make -j12"

if vim.fn.executable("rg") == 1 then
  g.gutentags_ctags_exclude = { "editor/**", "doc/**", "test[s]?/**" }
  g.gutentags_trace = 0
end
