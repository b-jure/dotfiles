local repo_name = "tree-sitter-tokudae"

local expand = vim.fn.expand
local M = vim.g.tokudae
  or {
    lua_config_path = expand("~/.config/nvim"),
    treesitter_parser_path = expand("~/.config/nvim/parser"), -- 'runtimepath'
    treesitter_queries_path = expand("~/.config/nvim/queries"), -- 'runtimepath'
    parser_repository_path = expand("~/.config/nvim/ts-parsers/") .. repo_name,
  }

local function log(msg, level)
  local function defered_notify()
    vim.notify("tree-sitter-tokudae: " .. msg, level)
  end
  vim.schedule(defered_notify)
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
    local function defered_update() vim.cmd("TokudaeTSUpdate") end
    loginfo("sync complete")
    vim.schedule(defered_update)
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

local function checkbuild(obj)
  if obj.code == 0 then
    local query_dir = M.parser_repository_path .. "/queries"
    local query_files = {
      "highlights.scm",
      "locals.scm",
      "tags.scm",
    }
    for _, fname in ipairs(query_files) do
      if
        not vim.uv.fs_copyfile(
          query_dir .. "/" .. fname,
          M.treesitter_queries_path .. "/" .. fname
        )
      then
        logerr(fmt("could not install '%s' query file", fname))
        return
      end
    end
    loginfo("update complete")
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
  opts.cwd = M.parser_repository_path
  vim.system({ "tree-sitter", "generate" }, opts, checkgenerate)
end, {})

-- parser name is tokudae but filetype is 'toku'
vim.treesitter.language.register("tokudae", { "toku" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "toku",
  callback = function() vim.treesitter.start() end,
})
