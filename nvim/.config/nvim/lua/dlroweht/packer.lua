vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- PACKER
    use('wbthomason/packer.nvim')

    -- FZF
    use({ 'junegunn/fzf' })

    -- MATCHUP
    use {
        'andymass/vim-matchup',
        setup = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end
    }
    -- TELESCOPE
    use({
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
        requires = 'nvim-lua/plenary.nvim'
    })

    -- THEMES
    use({ 'projekt0n/github-nvim-theme' })

    -- LUALINE
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    -- DEVICONS
    use('nvim-tree/nvim-web-devicons')

    -- BUFFERLINE
    use({
        'akinsho/bufferline.nvim',
        tag = "*",
        requires = 'nvim-tree/nvim-web-devicons'
    })

    -- TREESITTER
    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })

    -- TREESITTER TEXT OBJECTS PLUGIN
    use({
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter"
    })

    -- HARPOON
    use('ThePrimeagen/harpoon')

    -- COLORIZER
    use('norcalli/nvim-colorizer.lua')

    -- LSP
    use({
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            { -- Optional
                'williamboman/mason.nvim',
                run = ":MasonUpdate"
            }, { 'williamboman/mason-lspconfig.nvim' }, -- Optional
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' }, -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' } -- Required
        }
    })

    -- TMUX NAVIGATOR
    use('christoomey/vim-tmux-navigator')

    -- FORMATTER
    use('mhartington/formatter.nvim')

    -- MARKDOWN-PREVIEW
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end
    })

    -- AUTOCLOSE
    use('m4xshen/autoclose.nvim')

    -- STATUS LINE
    use { 'javiorfo/nvim-minimaline', requires = 'nvim-tree/nvim-web-devicons' }

end)
