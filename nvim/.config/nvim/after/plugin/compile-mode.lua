vim.api.nvim_set_hl(0, "CompileModeMessageRow", { fg = "#ff8700" })

vim.api.nvim_create_autocmd("User", {
  pattern = "CompilationFinished",
  callback = function(ev)
    local comp = require("compile-mode")
    if ev.data.code ~= 0 then -- compilation failed?
      comp.first_error({ count = 1 }) -- jump to first error
    end
  end,
})
