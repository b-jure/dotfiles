vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- PACKER
	use("wbthomason/packer.nvim")

	-- FZF for telescope
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	-- TELESCOPE
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		requires = "nvim-lua/plenary.nvim",
	})

	-- THEMES
	use({ "projekt0n/github-nvim-theme" })

	-- LUALINE
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})

	-- DEVICONS
	use("nvim-tree/nvim-web-devicons")

	-- HARPOON
	use("ThePrimeagen/harpoon")

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
end)
