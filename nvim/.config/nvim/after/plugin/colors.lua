-- Change foreground colour of 'Comment' highlight group
function CommentsColor(hex) vim.cmd("highlight Comment guifg=" .. "#" .. hex) end

-- Set line number colors
function LineNumberColors()
  vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#858585", bold = false })
  vim.api.nvim_set_hl(0, "LineNr", { fg = "white", bold = false })
  vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#858585", bold = false })
end

-- Setup colors (color-scheme picker)
function Cp(color)
  color = color or "gruvbox"
  if color == "gruvbox" then
    require("gruvbox").setup({
      terminal_colors = true,
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true,
      contrast = "",
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = false,
    })
    vim.o.background = "dark"
  elseif color == "no-clown-fiesta" then
    require("no-clown-fiesta").setup({
      transparent = false,
      styles = {
        comments = {},
        functions = {},
        keywords = {},
        lsp = { underline = true },
        match_paren = {},
        type = { bold = true },
        variable = {},
      },
    })
  end

  vim.cmd.colorscheme(color)
  LineNumberColors()
  CommentsColor("a89984")
  vim.api.nvim_command("highlight SignColumn guibg=#282828")
end

Cp("gruvbox")
