vim.cmd([[packadd packer.nvim]])

-- Template for 'use' function
-- use {
--   'myusername/example',        -- The plugin location string
--   -- The following keys are all optional
--   disable = boolean,           -- Mark a plugin as inactive
--   as = string,                 -- Specifies an alias under which to install the plugin
--   installer = function,        -- Specifies custom installer. See "custom installers" below.
--   updater = function,          -- Specifies custom updater. See "custom installers" below.
--   after = string or list,      -- Specifies plugins to load before this plugin. See "sequencing" below
--   rtp = string,                -- Specifies a subdirectory of the plugin to add to runtimepath.
--   opt = boolean,               -- Manually marks a plugin as optional.
--   bufread = boolean,           -- Manually specifying if a plugin needs BufRead after being loaded
--   branch = string,             -- Specifies a git branch to use
--   tag = string,                -- Specifies a git tag to use. Supports '*' for "latest tag"
--   commit = string,             -- Specifies a git commit to use
--   lock = boolean,              -- Skip updating this plugin in updates/syncs. Still cleans.
--   run = string, function, or table, -- Post-update/install hook. See "update/install hooks".
--   requires = string or list,   -- Specifies plugin dependencies. See "dependencies".
--   rocks = string or list,      -- Specifies Luarocks dependencies for the plugin
--   config = string or function, -- Specifies code to run after this plugin is loaded.
--   -- The setup key implies opt = true
--   setup = string or function,  -- Specifies code to run before this plugin is loaded. The code is ran even if
--                                -- the plugin is waiting for other conditions (ft, cond...) to be met.
--   -- The following keys all imply lazy-loading and imply opt = true
--   cmd = string or list,        -- Specifies commands which load this plugin. Can be an autocmd pattern.
--   ft = string or list,         -- Specifies filetypes which load this plugin.
--   keys = string or list,       -- Specifies maps which load this plugin. See "Keybindings".
--   event = string or list,      -- Specifies autocommand events which load this plugin.
--   fn = string or list          -- Specifies functions which load this plugin.
--   cond = string, function, or list of strings/functions,   -- Specifies a conditional test to load this plugin
--   module = string or list      -- Specifies Lua module names for require. When requiring a string which starts
--                                -- with one of these module names, the plugin will be loaded.
--   module_pattern = string/list -- Specifies Lua pattern of Lua module names for require. When
--                                -- requiring a string which matches one of these patterns, the plugin will be loaded.
-- }

return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    use("ludovicchabant/vim-gutentags")

    use({
        "nvim-telescope/telescope.nvim",
        requires = "nvim-lua/plenary.nvim",
    })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    use({
        "nvim-telescope/telescope-bibtex.nvim",
        requires = {
            { "nvim-telescope/telescope.nvim" },
        },
        ft = {"tex", "markdown"},
    })

    use({ "shortcuts/no-neck-pain.nvim", tag = "*" })

    use("ggandor/leap.nvim")

    use("nvim-tree/nvim-web-devicons")

    use("stevearc/oil.nvim")

    use("norcalli/nvim-colorizer.lua")

    use({
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        requires = {
            -- LSP Support
            { "neovim/nvim-lspconfig" }, -- Required
            { -- Optional
                "williamboman/mason.nvim",
                run = ":MasonUpdate",
            },
            { "williamboman/mason-lspconfig.nvim" }, -- Optional
            -- Autocompletion
            { "hrsh7th/nvim-cmp" }, -- Required
            { "hrsh7th/cmp-nvim-lsp" }, -- Required
            { "L3MON4D3/LuaSnip" }, -- Required
        },
    })

    use({
        "nvim-lualine/lualine.nvim",
        requires = { "nvim-tree/nvim-web-devicons", opt = true },
    })

    use({
        "iamcco/markdown-preview.nvim",
        run = function()
            vim.fn["mkdp#util#install"]()
        end,
    })

    use({ "tpope/vim-fugitive" })

    use({ "ellisonleao/gruvbox.nvim" })

    use({ "mhartington/formatter.nvim" })

    use({
        "nvim-orgmode/orgmode",
        config = function()
            require("orgmode").setup({})
        end,
    })

    use({
        "goolord/alpha-nvim",
        -- dependencies = { 'echasnovski/mini.icons' },
        requires = { "nvim-tree/nvim-web-devicons" },
    })

    use("lervag/vimtex")

    use("micangl/cmp-vimtex")

    use({ "folke/which-key.nvim", ft = { "org", "tex" } })
end)
