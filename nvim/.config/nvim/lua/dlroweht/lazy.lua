local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = { -- https://lazy.folke.io/spec
    { -- TREESITTER
      "nvim-treesitter/nvim-treesitter",
      build = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
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
    { -- NONECKPAIN
      "shortcuts/no-neck-pain.nvim",
      version = "*",
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
    { -- MARKDOWNPREVIEW
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
    { -- GRUVBOXTHEME
      "ellisonleao/gruvbox.nvim",
    },
    { -- FORMATTER
      "mhartington/formatter.nvim",
    },
    { -- VIMGUTENTAGS
      "ludovicchabant/vim-gutentags",
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
    { -- WHICHKEY
      "folke/which-key.nvim",
      ft = { "org", "tex" },
    },
    { -- GITSIGNS
      "lewis6991/gitsigns.nvim",
    },
    { -- TREESITTERAUTOTAG (HTML)
      "windwp/nvim-ts-autotag",
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
})
