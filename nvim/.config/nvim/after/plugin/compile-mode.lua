vim.api.nvim_set_hl(0, "CompileModeMessageRow", { fg = "#ff8700" })

vim.api.nvim_create_autocmd("User", {
  pattern = "CompilationFinished",
  callback = function(ev)
    if ev.code ~= 0 then -- compilation failed?
      require("compile-mode").first_error({ count = 1 }) -- jump to first error
    end
  end,
})
