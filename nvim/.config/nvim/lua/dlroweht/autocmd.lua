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

-- Define the ctags command with options
local ctags_command = {
  cmd = "ctags",
  args = {"-R", "--exclude=.git", "--exclude=node_modules", "*.c", "*.h"},
}

-- Function to run ctags silently
local function run_ctags()
  local full_command = table.concat(vim.tbl_flatten({ctags_command.cmd, ctags_command.args}), " ")
  vim.fn.system(full_command)
end


vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter", "BufWritePost"}, {
    pattern = {"*.c", "*.h"},
    callback = run_ctags,
})
