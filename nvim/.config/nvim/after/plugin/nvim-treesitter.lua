local ts = require("nvim-treesitter")
local langs = {
  "c",
  "lua",
  "latex",
  "vim",
  "vimdoc",
  "query",
  "markdown",
  "markdown_inline",
  "javascript",
  "python",
}

ts.setup()

vim.api.nvim_create_autocmd("FileType", {
  pattern = langs,
  callback = function() vim.treesitter.start() end,
})

ts.install(langs)
ts.update()
