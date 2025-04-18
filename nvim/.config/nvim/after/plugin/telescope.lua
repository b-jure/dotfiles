local telescope_bibdir = vim.fn.expand("~/library/texmf/bibtex/bib")
local bibfiles = {
  telescope_bibdir .. "/Zotero.bib",
}

require("telescope").setup({
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "-s",
    },
    mappings = {
      i = { ["<c-t>"] = open_with_trouble },
      n = { ["<c-t>"] = open_with_trouble },
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
          case_mode = "respect_case", -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
        bibtex = {
          -- Depth for the *.bib file
          depth = 2,
          -- Custom format for citation label
          custom_formats = {},
          -- Format to use for citation label.
          -- Try to match the filetype by default, or use 'plain'
          format = "",
          -- Path to global bibliographies (placed outside of the project)
          global_files = bibfiles,
          -- Define the search keys to use in the picker
          search_keys = { "author", "year", "title" },
          -- Template for the formatted citation
          citation_format = "{{author}} ({{year}}), {{title}}.",
          -- Only use initials for the authors first name
          citation_trim_firstname = true,
          -- Max number of authors to write in the formatted citation
          -- following authors will be replaced by "et al."
          citation_max_auth = 2,
          -- Context awareness disabled by default
          context = true,
          -- Fallback to global/directory .bib files if context not found
          -- This setting has no effect if context = false
          context_fallback = true,
          -- Wrapping in the preview window is disabled by default
          wrap = false,
        },
      },
    },
  },
})

require("telescope").load_extension("fzf")

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "*.tex", "*.md" },
  callback = function()
    require("telescope").load_extension("bibtex")
  end,
})

local builtin = require("telescope.builtin")

local function keymap(mode, keybind, action)
  vim.keymap.set(mode, keybind, action, { noremap = true, silent = true })
end

local function open_cfg_files()
  builtin.find_files({ cwd = vim.fn.stdpath("config") })
end

local function open_rfc()
  builtin.find_files({ cwd = "/home/dlroweht/docs/rfc" })
end

local function grep_reg_string()
  return builtin.grep_string({ search = vim.fn.getreg('""') })
end

local function open_man_pages()
  return builtin.man_pages({ sections = { "2", "3" } })
end

local function open_c_headers()
  builtin.find_files({
    cwd = "/usr/include",
    find_command = { "find", ".", "1", "-type", "f", "-name", "*.h" },
  })
end

local function grep_c_headers()
  builtin.live_grep({
    cwd = "/usr/include",
    glob_pattern = "*.h",
    max_results = 100,
  })
end

keymap("n", "<leader>pp", open_cfg_files)
keymap("n", "<leader>pk", builtin.keymaps)
keymap("n", "<C-p>", builtin.find_files)
keymap("n", "<leader>ph", builtin.help_tags)
keymap("n", "<leader>ps", builtin.live_grep)
keymap("n", "<leader>pr", grep_reg_string)
keymap("n", "<leader>pm", open_man_pages)
keymap("n", "<leader>pc", open_c_headers)
keymap("n", "<leader>pd", grep_c_headers)
keymap("n", "<M-r>", open_rfc)
