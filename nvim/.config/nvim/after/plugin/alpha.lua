local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
	"                                                                       ",
	"                                                                     ",
	"       ████ ██████           █████      ██                     ",
	"      ███████████             █████                             ",
	"      █████████ ███████████████████ ███   ███████████   ",
	"     █████████  ███    █████████████ █████ ██████████████   ",
	"    █████████ ██████████ █████████ █████ █████ ████ █████   ",
	"  ███████████ ███    ███ █████████ █████ █████ ████ █████  ",
	" ██████  █████████████████████ ████ █████ █████ ████ ██████ ",
	"                                                                       ",
}

dashboard.section.header.opts.hl = "Title"

dashboard.section.buttons.val = {
	dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("r", "󰈚  > Recent", ":Telescope oldfiles <CR>"),
	dashboard.button("f", "󰈞  > Find file", ":cd $HOME/prog | Telescope find_files<CR>"),
	dashboard.button(
		"s",
		"  > Config",
		':lua require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })<CR>'
	),
    dashboard.button("p", "  > Plugins", "<cmd>PackerStatus<cr>"),
    dashboard.button("h", "  > Checkhealth", "<cmd>checkhealth<cr>"),
	dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
}

alpha.setup(dashboard.opts)

vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
