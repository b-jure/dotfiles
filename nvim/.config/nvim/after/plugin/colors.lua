-- Change foreground colour of 'Comment' highlight group
function CommentsColor(hex)
	vim.cmd("highlight Comment guifg=" .. "#" .. hex)
end

-- Set line number colors
function LineNumberColors()
	vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#858585", bold = false })
	vim.api.nvim_set_hl(0, "LineNr", { fg = "white", bold = false })
	vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#858585", bold = false })
end

-- Setup colors (color-scheme picker)
function Cp(color)
	color = color or "gruvbox"
	if color == "gruvbox" then
		require("gruvbox").setup({
			terminal_colors = true,
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = true,
				emphasis = true,
				comments = true,
				operators = false,
				folds = true,
			},
			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			invert_intend_guides = false,
			inverse = true,
			contrast = "",
			palette_overrides = {},
			overrides = {},
			dim_inactive = false,
			transparent_mode = false,
		})
	end
	vim.o.background = "dark"
	vim.cmd.colorscheme(color)
	LineNumberColors()
	-- CommentsColor("d65d0e")
end

Cp("gruvbox")
