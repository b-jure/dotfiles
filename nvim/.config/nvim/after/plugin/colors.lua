-- Set color-scheme
function ColorSchemeSet(color) vim.cmd.colorscheme(color) end

-- Change foreground colour of 'Comment' highlight group
function CommentsColor(hex) vim.cmd("highlight Comment guifg=" .. "#" .. hex) end

-- Set line number colors
function LineNumberColors()
    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#858585', bold = false })
    vim.api.nvim_set_hl(0, 'LineNr', { fg = 'white', bold = false })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#858585', bold = false })
end

-- Setup colors (color-scheme picker)
function Cp(color)
    color = color or "github_dark_high_contrast"
    if (color:find("tokyonight", 1, true) == 1) then
        require("tokyonight").setup({
            style = "night",
            terminal_colors = true,
            styles = {
                comments = { italic = true },
                sidebars = "dark",
                floats = "dark"
            },
            sidebars = { "qf", "help" },
            lualine_bold = true
        })
    elseif (color:find("oxocarbon", 1, true) == 1) then
        vim.opt.background = "dark" -- set this to dark or light
    elseif (color:find("github_dark_hight_contrast", 1, true) == 1) then
        -- Default options
        require('github-theme').setup({
            options = {
                -- Compiled file's destination location
                compile_path = vim.fn.stdpath('cache') .. '/github-theme',
                compile_file_suffix = '_compiled', -- Compiled file suffix
                hide_end_of_buffer = true, -- Hide the '~' character at the end of the buffer for a cleaner look
                hide_nc_statusline = true, -- Override the underline style for non-active statuslines
                transparent = false, -- Disable setting background
                terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
                dim_inactive = false, -- Non focused panes set to alternative background
                module_default = true, -- Default enable value for modules
                styles = { -- Style to be applied to different syntax groups
                    comments = 'NONE', -- Value is any valid attr-list value `:help attr-list`
                    functions = 'NONE',
                    keywords = 'NONE',
                    variables = 'NONE',
                    conditionals = 'NONE',
                    constants = 'NONE',
                    numbers = 'NONE',
                    operators = 'NONE',
                    strings = 'NONE',
                    types = 'NONE'
                },
                inverse = { -- Inverse highlight for different types
                    match_paren = false,
                    visual = false,
                    search = false
                },
                darken = { -- Darken floating windows and sidebar-like windows
                    floats = false,
                    sidebars = {
                        enabled = true,
                        list = {} -- Apply dark background to specific windows
                    }
                },
                modules = { -- List of various plugins and additional options
                    -- ...
                }
            },
            palettes = {},
            specs = {},
            groups = {}
        })
    end
    ColorSchemeSet(color)
    LineNumberColors()
    -- CommentsColor("d65d0e")
end

Cp()
