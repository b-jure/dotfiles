local o = vim.o
local g = vim.g

-- TUI
vim.api.nvim_set_hl(0, "ColorColumn", { fg = "#505050", bg = "#505050" })
vim.opt.colorcolumn = "80"
g.c_no_curly_error = true
g.c_syntax_for_h = true
o.termguicolors = true
o.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr-o:hor20,o:hor50,a:blinkon350"
o.number = true
o.numberwidth = 5
o.cursorline = true
o.relativenumber = true
o.signcolumn = "number"
o.cursorline = false
o.cursorlineopt = "screenline"
o.cole = 2
o.scrolloff = 8
g.title = true
o.termsync = true
-- indentation
o.cindent = true
o.cinkeys = "0{,0},0),0],:,!^F,o,O,e"
o.indentkeys = "0{,0},0),0],:,!^F,o,O,e"
o.cinoptions = "l1,W2,#0"
o.autoindent = true
-- wrap text
o.wrap = true
o.textwidth = 80
-- consistent indentation
o.tabstop = 8
o.shiftwidth = 2
o.softtabstop = 2
o.expandtab = true
-- backup and writes
o.updatetime = 50
o.backup = false
o.writebackup = false
o.undofile = false
o.swapfile = false
o.undodir = ".vim_undo"
-- window split
o.splitright = true
o.splitbelow = true
-- do not change directory
o.autochdir = false
-- netrw
g.netrw_special_syntax = true
g.netrw_browse_split = 0
g.netrw_banner = 0
g.netrw_winsize = 25
g.netrw_liststyle = 1
-- other
g.no_man_maps = true
o.cedit = "<C-s>"
o.history = 200
o.jumpoptions = "view"
o.list = false
o.clipboard = "unnamedplus,unnamed"
o.ignorecase = true
o.smartcase = true
o.signcolumn = "auto"
o.errorformat = "%f:%l: %m"
o.makeprg = "make"

-- gutentags
if vim.fn.executable("rg") == 1 then
  g.gutentags_ctags_exclude = { "editor/**", "doc[s]?/**", "test[s]?/**" }
  g.gutentags_trace = 0
end
