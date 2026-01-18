local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
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
      lazy = false,
      build = ":TSUpdate",
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
    { -- SMARTSPLITS
      "mrjones2014/smart-splits.nvim",
    },
    { -- TODOCOMMENTS
      "folke/todo-comments.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
    },
    { -- MARKDOWNPREVIEW
      "iamcco/markdown-preview.nvim",
      cmd = {
        "MarkdownPreviewToggle",
        "MarkdownPreview",
        "MarkdownPreviewStop",
      },
      ft = { "markdown" },
      build = function() vim.fn["mkdp#util#install"]() end,
    },
    { -- COMPILEMODE
      --"ej-shafran/compile-mode.nvim",
      dir = "/home/dlroweht/probe/lua/compile-mode.nvim",
      branch = "latest",
      dependencies = {
        "nvim-lua/plenary.nvim",
        { "m00qek/baleia.nvim", tag = "v1.3.0" },
      },
      config = function()
        vim.g.compile_mode = {
          default_command = "make -B -j12",
          recompile_no_fail = true,
          baleia_setup = true,
        }
      end,
    },
    { -- NVIMTMUXNAVIGATOR
      "alexghergh/nvim-tmux-navigation",
      config = function()
        require("nvim-tmux-navigation").setup({
          disable_when_zoomed = true, -- defaults to false
          keybindings = {
            left = "<C-j>",
            down = "<C-k>",
            up = "<C-l>",
            right = "<Insert>",
          },
        })
      end,
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
})
