local function get_visual_selection_range()
  local start_pos = vim.fn.getpos("v")
  local end_pos = vim.fn.getpos(".")
  local start_line = start_pos[2]
  local end_line = end_pos[2]
  if start_line > end_line then
    return end_line, start_line
  else
    return start_line, end_line
  end
end

-- Remove quickfix item at the cursor
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

-- Remove quickfix item(s) in visual selection
local function remove_qf_visual()
  local mode = vim.fn.mode()
  if mode == "v" or mode == "V" or mode == "\22" then
    local s, e = get_visual_selection_range()
    local qf_all = vim.fn.getqflist()
    for i = s, e do
      table.remove(qf_all, s)
    end
    vim.fn.setqflist(qf_all, "r")
    if s > 1 then
      vim.fn.execute(tostring(s) .. "cfirst")
    end
    vim.cmd("copen")
  end
end

vim.api.nvim_create_user_command("RemoveQFItem", remove_qf_item, {})
vim.api.nvim_create_user_command("RemoveQFItemVisual", remove_qf_visual, {})

-- Use autocmd to only map dd in the quickfix window
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.api.nvim_buf_set_keymap(
      0,
      "n",
      "dd",
      ":RemoveQFItem<CR>",
      { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
      0,
      "v",
      "d",
      "",
      { noremap = true, silent = true, callback = remove_qf_visual }
    )
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "CompilationFinished",
  callback = function(ev)
    if ev.code ~= 0 then -- compilation failed?
      require("compile-mode").first_error({ count = 1 }) -- jump to first error
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.c", "*.h", "*.lua", "*.py" },
  callback = function()
    local is_git = vim.fn.trim(
      vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null")
    )
    if is_git == "true" then -- in git repository?
      local root = vim.fn.trim(vim.fn.system("git rev-parse --show-toplevel"))
      local path = root .. "/.git/hooks/ctags"
      if vim.loop.fs_stat(path) then -- .git_config is setup correctly?
        vim.fn.system(path)
      end
    end
  end,
})

-- set filetype to 'systemd' for systemd timers and services
vim.api.nvim_create_autocmd({ "BufRead" }, {
  pattern = { "*.timer", "*.service" },
  callback = function() vim.bo[0].filetype = "systemd" end,
})
