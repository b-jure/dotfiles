require("conform").setup({
  formatters_by_ft = {
    c = { "clang-format" },
    lua = { "stylua" },
    go = { "gofmt" },
    rust = { "rustfmt" },
    python = { "black" },
    javascript = { "deno_fmt" },
    typescript = { "deno_fmt" },
    json = { "deno_fmt" },
    sh = { "shfmt" },
  },
  log_level = vim.log.levels.ERROR,
  notify_on_error = true,
  notify_no_formatters = true,
  formatters = {
    ["clang-format"] = {
      append_args = {
        "--style=file:" .. vim.fn.expand("~/.config/formatting/.clang-format"),
      },
    },
    stylua = {
      append_args = { "-f", vim.fn.expand("~/.config/stylua/.stylua.toml") },
    },
  },
})

local last_notified_filetype = nil
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = "*",
  callback = function(args)
    require("conform").format({
      timeout_ms = 2000,
      stop_after_first = true,
      bufnr = args.buf,
    })
  end,
})
