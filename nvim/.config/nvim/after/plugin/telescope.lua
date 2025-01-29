local telescope_bibdir = vim.fn.expand("~/library/texmf/bibtex/bib")
local bibfiles = {
    telescope_bibdir .. "/Zotero.bib"
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

local opencfgfiles = function()
    builtin.find_files({ cwd = vim.fn.stdpath("config") })
end

local openrfc = function()
    builtin.find_files({ cwd = "/home/dlroweht/docs/rfc" })
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
keymap("n", "<leader>pc", "<cmd>Telescope bibtex<CR>")
keymap("n", "<M-r>", openrfc)
