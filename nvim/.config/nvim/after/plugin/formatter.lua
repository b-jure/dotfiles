require("formatter").setup({
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	-- All formatter configurations are opt-in
	filetype = {
		c = {
			function()
				return {
					exe = "clang-format",
					args = {
						"--style=file:/home/dlroweht/dotfiles/formatting/.config/formatting/.clang-format",
						"-i",
					},
					stdin = false,
				}
			end,
		},
		json = {
			function()
				return {
					exe = "clang-format",
					args = { "-i" },
					stdin = false,
				}
			end,
		},
		lua = {
			function()
				return {
					exe = "stylua",
					args = {
						"-f ~/.config/stylua/.stylua.toml",
					},
					stdin = false,
				}
			end,
		},
		js = {
			function()
				return {
					exe = "clang-format",
					args = { "-i" },
					stdin = false,
				}
			end,
		},
		sh = {
			function()
				return {
					exe = "shfmt",
					args = { "-w" },
					stdin = false,
				}
			end,
		},
	},
})

-- vim.keymap.set("n", "<leader>f", ":Format<CR>", { noremap = true, silent = true })
