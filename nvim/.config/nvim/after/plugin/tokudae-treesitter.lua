local repo_name = "tree-sitter-tokudae"

local expand = vim.fn.expand
local M = vim.g.tokudae
  or {
    lua_config_path = expand("~/.config/nvim"),
    treesitter_parser_path = expand("~/.config/nvim/parser"), -- 'runtimepath'
    treesitter_queries_path = expand("~/.config/nvim/queries/tokudae"), -- 'runtimepath'
    parser_repository_path = expand("~/.config/nvim/ts-parsers/" .. repo_name),
    parser_filename = "tokudae.so",
  }

local function log(msg, level)
  vim.schedule(function()
    vim.notify(repo_name .. ": " .. msg, level)
    if level == vim.log.levels.ERROR then
      vim.g.tokudae_is_updating = false
    end
  end)
end

local function logerr(msg) log(msg, vim.log.levels.ERROR) end

local function loginfo(msg) log(msg, vim.log.levels.INFO) end

local fmt = string.format
local freadable = vim.fn.filereadable

if type(M) ~= "table" then
  logerr(fmt("expected 'vim.g.tokudae' to be a table, instead got %s", type(M)))
  return
end

for k, path in pairs(M) do
  if not freadable(path) then
    logerr(fmt("%s ('%s') does not exist", k, path))
    return
  end
end

-- default opts for 'vim.system'
local opts = { stdout = false, stderr = false, timeout = 60000 }

local function timeouterror(what)
  logerr(
    fmt("%s failed (took longer than %s seconds)", what, opts.timeout / 1000)
  )
end

local function cmderror(what, cmd)
  logerr(fmt("%s failed (aka '%s' failed)", what, cmd))
end

local function timeout(code) return opts.timeout and code == 124 end

local function checksync(obj)
  if obj.code == 0 then -- ok?
    loginfo("sync complete")
    vim.schedule(function() vim.cmd("TokudaeTSUpdate") end)
  elseif timeout(obj.code) then
    timeouterror("sync")
  else
    cmderror("sync", "git pull")
  end
end

vim.api.nvim_create_user_command("TokudaeTSSync", function(t)
  opts.cwd = M.parser_repository_path
  vim.system({ "git", "pull" }, opts, checksync)
end, {})

local copyfile = vim.uv.fs_copyfile

local function install_query_files(query_dir)
  local srcdir = query_dir .. "/"
  local destdir = M.treesitter_queries_path .. "/"
  local query_files = {
    "highlights.scm",
    "locals.scm",
    "tags.scm",
  }
  for _, fname in ipairs(query_files) do
    local srcfile = srcdir .. fname
    local destfile = destdir .. fname
    if not copyfile(srcfile, destfile) then
      logerr(
        fmt(
          "could not install query file (from '%s' to '%s')",
          srcfile,
          destfile
        )
      )
      return false
    end
  end
  return true
end

local function install_parser(parserdir, parser_name)
  local parserpath = parserdir .. "/" .. parser_name
  local parserdest = M.treesitter_parser_path .. "/" .. parser_name
  if not copyfile(parserpath, parserdest) then
    logerr(
      fmt(
        "could not install tokudae parser (from '%s' to '%s')",
        parserpath,
        parserdest
      )
    )
    return false
  end
  return true
end

local function checkbuild(obj)
  if obj.code == 0 then
    if not install_parser(M.parser_repository_path, M.parser_filename) then
      return
    end
    if not install_query_files(M.parser_repository_path .. "/queries") then
      return
    end
    loginfo("update complete")
    vim.g.tokudae_is_updating = false
    vim.schedule(function() vim.treesitter.start() end)
  elseif timeout(obj.code) then
    timeouterror("update")
  else
    cmderror("update", "tree-sitter build")
  end
end

local function checkgenerate(obj)
  if obj.code == 0 then
    opts.cwd = M.parser_repository_path
    vim.system({ "tree-sitter", "build" }, opts, checkbuild)
  elseif timeout(obj.code) then
    timeouterror("update")
  else
    cmderror("update", "tree-sitter generate")
  end
end

vim.api.nvim_create_user_command("TokudaeTSUpdate", function(t)
  if vim.g.tokudae_is_updating then
    return
  else
    vim.g.tokudae_is_updating = true
    vim.treesitter.stop()
  end
  opts.cwd = M.parser_repository_path
  vim.system({ "tree-sitter", "generate" }, opts, checkgenerate)
end, {})

vim.api.nvim_create_user_command("TokudaeTSUpdateQueries", function(t)
  if install_query_files(M.parser_repository_path .. "/queries") then
    loginfo("queries updated")
    if vim.bo.filetype == "toku" then
      vim.treesitter.stop()
      vim.treesitter.start()
    end
  end
end, {})

-- parser name is tokudae but filetype is 'toku'
vim.treesitter.language.register("tokudae", { "toku" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "tokudae",
  callback = function() vim.treesitter.start() end,
})
