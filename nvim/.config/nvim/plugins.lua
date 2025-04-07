return { -- Plugin Spec: https://lazy.folke.io/spec
  { -- TREESITTER
    "nvim-treesitter/nvim-treesitter",
    build = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })()
      ts_update()
    end,
  },
  { -- TELESCOPE
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { -- native FZF for TELESCOPE
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
  { -- bibtex for TELESCOPE
    "nvim-telescope/telescope-bibtex.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    ft = { "tex", "markdown" },
  },
  { -- NO_NECK_PAIN
    "shortcuts/no-neck-pain.nvim",
    tag = "*",
  },
  { -- DEVICONS
    "nvim-tree/nvim-web-devicons",
  },
  { -- OIL
    "stevearc/oil.nvim",
  },
  { -- COLORIZER
    "norcalli/nvim-colorizer.lua",
  },
  { -- LUALINE
    "nvim-lualine/lualine.nvim",
    dependencies = { { "nvim-tree/nvim-web-devicons", optional = true } },
  },
  { -- MARKDOWN_PREVIEW
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  { -- FUGITIVE
    "tpope/vim-fugitive",
  },
  { -- GRUVBOX_THEME
    "ellisonleao/gruvbox.nvim",
  },
  { -- FORMATTER
    "mhartington/formatter.nvim",
  },
  { -- ORGMODE
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    config = function()
      -- Setup orgmode
      require("orgmode").setup({})
    end,
  },
  { -- ALPHA
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  { -- VIMTEX
    "lervag/vimtex",
  },
  { -- WHICH_KEY
    "folke/which-key.nvim",
    ft = { "org", "tex" },
  },
  { -- GIT_SIGNS
    "lewis6991/gitsigns.nvim",
  },
  { -- TREESITTER_AUTOTAG (HTML)
    "windwp/nvim-ts-autotag",
  },
}
