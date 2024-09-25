require("better_escape").setup {
    timeout = vim.o.timeoutlen,
    default_mappings = false,
    mappings = {
        i = {
            k = {
                u = "<Esc>",
            },
        },
        c = {
            k = {
                u = "<Esc>",
            },
        },
        t = {
            k = {
                u = "<C-\\><C-n>",
            },
        },
        v = {
            k = {
                u = "<Esc>",
            },
        },
        s = {
            k = {
                u = "<Esc>",
            },
        },
    },
}

-- this plugin unmaps movement keys 
-- in visual mode cuz bad design
vim.keymap.set({ "n", "v" }, "j", "h", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "k", "j", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "l", "k", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, ";", "l", { noremap = true, silent = true })
