vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

    use("ludovicchabant/vim-gutentags")

	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		requires = "nvim-lua/plenary.nvim",
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

	use("christoomey/vim-tmux-navigator")

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
end)
