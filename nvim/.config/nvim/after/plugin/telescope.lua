require("telescope").setup({
    defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "-s"
        },
    },
	pickers = {
		buffers = {
			show_all_buffers = true,
			sort_lastused = true,
			theme = "dropdown",
			previewer = true,
			mappings = {
				i = {
					["<c-d>"] = "delete_buffer",
					["<c-e>"] = "confirm_selection",
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

require("telescope").load_extension("fzf")

local builtin = require("telescope.builtin")

local function keymap(mode, keybind, action)
	vim.keymap.set(mode, keybind, action, { noremap = true, silent = true })
end

local opencfgfiles = function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end

local grepregstring = function()
	return builtin.grep_string({ search = vim.fn.getreg('""') })
end

local openmanpages = function()
	return builtin.man_pages({ sections = { "2", "3" } })
end

keymap("n", "<leader>pp", opencfgfiles)
-- keymap("n", "<leader>pk", builtin.keymaps) ** doesn't work anymore ??? **
keymap("n", "<C-p>", builtin.find_files)
-- keymap("n", "<leader>pb", builtin.buffers) ** doesn't work anymore ??? **
keymap("n", "<leader>ph", builtin.help_tags)
keymap("n", "<leader>pd", builtin.diagnostics)
keymap("n", "<leader>ps", builtin.live_grep)
keymap("n", "<leader>pr", grepregstring)
keymap("n", "<leader>pm", openmanpages)
