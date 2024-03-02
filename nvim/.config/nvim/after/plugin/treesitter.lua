require("nvim-treesitter.configs").setup {
    ensure_installed = {
        "c", "cmake", "lua", "rust", "fish", "bash", "vim", "python"
    },
    sync_install = false,
    auto_install = true,

    highlight = { enable = true },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<CR>',
            scope_incremental = '<CR>',
            node_incremental = '<TAB>',
            node_decremental = '<S-TAB>'
        }
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner'
            }
        },
        swap = {
            enable = true,
            swap_next = { ["<leader>sn"] = "@parameter.inner" },
            swap_previous = { ["<leader>sp"] = "@parameter.inner" }
        }
    }
}
