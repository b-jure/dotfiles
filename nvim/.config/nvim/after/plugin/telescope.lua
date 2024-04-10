require("telescope").setup({
	pickers = {
		buffers = {
			show_all_buffers = true,
			sort_lastused = true,
			theme = "dropdown",
			previewer = true,
			mappings = {
				i = {
					["<c-d>"] = "delete_buffer",
				},
			},
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
				},
			},
		},
	},
})

require('telescope').load_extension('fzf')

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<C-p>", builtin.find_files, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>pb", builtin.buffers, { desc = "[pb] Find existing buffers" })
vim.keymap.set("n", "<leader>ph", builtin.help_tags, { desc = "[ph] Sarch help tags" })
vim.keymap.set("n", "<leader>pd", builtin.diagnostics, { desc = "[pd] Search diagnostics" })
vim.keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep: ") })
end)
