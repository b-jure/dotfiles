vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")

-- When using `dd` in the quickfix list, remove the item from the quickfix list.
local function remove_qf_item()
  local cur_qf_idx = vim.fn.line(".")
  local qf_all = vim.fn.getqflist()
  table.remove(qf_all, cur_qf_idx)
  vim.fn.setqflist(qf_all, "r")
  if cur_qf_idx > 1 then
    vim.fn.execute(tostring(cur_qf_idx) .. "cfirst")
  end
  vim.cmd("copen")
end

vim.api.nvim_create_user_command("RemoveQFItem", remove_qf_item, {})

-- Use autocmd to only map dd in the quickfix window
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "dd", ":RemoveQFItem<CR>", { noremap = true, silent = true })
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.c", "*.h", "*.lua", "*.py" },
  callback = function()
    local is_git = vim.fn.trim(vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null"))
    if is_git == "true" then -- in git repository?
      local root = vim.fn.trim(vim.fn.system("git rev-parse --show-toplevel"))
      local path = root .. "/.git/hooks/ctags"
      if vim.loop.fs_stat(path) then -- .git_config is setup correctly?
        vim.fn.system(path)
      end
    end
  end,
})
