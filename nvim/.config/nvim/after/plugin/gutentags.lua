if vim.fn.executable("rg") == 1 then
  local g = vim.g
  g.gutentags_add_default_project_roots = 0
  g.gutentags_project_root = { "package.json", ".git", "Makefile" }
  g.gutentags_ctags_exclude = { "*.html", "*.json" }
  --g.gutentags_cache_dir = vim.fn.expand("~/.cache/vim/ctags")
  g.gutentags_trace = 0
end
