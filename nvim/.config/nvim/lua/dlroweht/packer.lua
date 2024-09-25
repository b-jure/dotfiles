vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- PACKER
	use("wbthomason/packer.nvim")

	-- FZF (for telescope)
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	-- TELESCOPE
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		requires = "nvim-lua/plenary.nvim",
	})

	-- NONECKPAIN
	use({ "shortcuts/no-neck-pain.nvim", tag = "*" })

    -- LEAP
    use("ggandor/leap.nvim")

	-- ICONS
	use("nvim-tree/nvim-web-devicons")

	-- OIL
	use("stevearc/oil.nvim")

	-- COLORIZER
	use("norcalli/nvim-colorizer.lua")

	-- LSP
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

	-- TMUX NAVIGATOR
	use("christoomey/vim-tmux-navigator")

	-- LUA LINE
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})

	-- MARKDOWN-PREVIEW
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	-- FUGITIVE
	use({ "tpope/vim-fugitive" })

	-- GRUVBOX THEME
	use({ "ellisonleao/gruvbox.nvim" })

	-- FORMATTER
	use({ "mhartington/formatter.nvim" })

	-- ORG MODE
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

    use("max397574/better-escape.nvim")
end)
