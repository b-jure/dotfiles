local fzf = require("fzf-lua")
require("fzf-lua").setup({
  keymap = {
    -- Below are the default binds, setting any value in these tables will override
    -- the defaults, to inherit from the defaults change [1] from `false` to `true`
    fzf = {
      -- fzf '--bind=' options
      -- true,        -- uncomment to inherit all the below in your custom config
      ["ctrl-c"] = "abort",
      ["ctrl-u"] = "unix-line-discard",
      ["ctrl-d"] = "half-page-down",
      ["ctrl-u"] = "half-page-up",
      ["ctrl-a"] = "beginning-of-line",
      ["ctrl-e"] = "end-of-line",
      ["ctrl-a"] = "toggle-all",
      ["alt-g"] = "first",
      ["alt-G"] = "last",
      -- Only valid with fzf previewers (bat/cat/git/etc)
      ["f3"] = "toggle-preview-wrap",
      ["f4"] = "toggle-preview",
      ["shift-down"] = "preview-page-down",
      ["shift-up"] = "preview-page-up",
    },
  },
  actions = {
    -- Below are the default actions, setting any value in these tables will override
    -- the defaults, to inherit from the defaults change [1] from `false` to `true`
    files = {
      -- true, -- uncomment to inherit all the below in your custom config
      -- Pickers inheriting these actions:
      --   files, git_files, git_status, grep, lsp, oldfiles, quickfix, loclist,
      --   tags, btags, args, buffers, tabs, lines, blines
      -- `file_edit_or_qf` opens a single selection or sends multiple selection to quickfix
      -- replace `enter` with `file_edit` to open all files/bufs whether single or multiple
      -- replace `enter` with `file_switch_or_edit` to attempt a switch in current tab first
      ["enter"] = fzf.actions.file_edit_or_qf,
      ["ctrl-s"] = fzf.actions.file_split,
      ["ctrl-v"] = fzf.actions.file_vsplit,
      --["ctrl-t"] = fzf.actions.file_tabedit,
      ["ctrl-Q"] = fzf.actions.file_sel_to_qf,
      ["ctrl-q"] = fzf.actions.file_sel_to_ll,
    },
  },
})

local function map_key(modes, k, v)
  vim.keymap.set(modes, k, v, { noremap = true, silent = true })
end

vim.api.nvim_create_user_command(
  "ConfigFilesPicker",
  function() fzf.files({ cwd = vim.fn.stdpath("config") }) end,
  { desc = "Open nvim config files in fzf-lua 'files' picker" }
)

vim.api.nvim_create_user_command(
  "RecentFilesPicker",
  fzf.oldfiles,
  { desc = "Open recent files in fzf-lua 'oldfiles' picker" }
)

vim.api.nvim_create_user_command("DirsPicker", function()
  local fzf = require("fzf-lua")
  fzf.files({
    prompt = "Dirs> ",
    -- Use fd for directories only, max depth 1, strip cwd prefix
    cmd = "fd --type d --max-depth 1 --strip-cwd-prefix",
    actions = {
      -- Default action: cd into directory + open files picker
      ["default"] = function(selected)
        if selected and #selected > 0 then
          local dir = selected[1]:gsub("^[^%w]+%s*", "") -- remove icon
          vim.cmd("cd " .. dir)
          vim.cmd("edit .")
        end
      end,
    },
  })
end, { desc = "Open directories in the current directory in fzf-lua picker" })

map_key("n", "<C-p>", fzf.files)
map_key("n", "<leader>pp", ":ConfigFilesPicker<CR>")
map_key("n", "<leader>po", ":RecentFilesPicker<CR>")
map_key("n", "<leader>ps", fzf.live_grep_native)
map_key("n", "<leader>pS", fzf.lgrep_curbuf)
map_key("n", "<leader>pw", fzf.grep_cword)
map_key("n", "<leader>pm", fzf.manpages)
map_key("n", "<leader>ph", fzf.helptags)
map_key("n", "<leader>pk", fzf.keymaps)
map_key("n", "<leader>pc", fzf.command_history)
map_key("n", "<M-r>", function() fzf.files({ cwd = "~/docs/rfc" }) end)
map_key(
  "n",
  "<leader>pr",
  function() fzf.live_grep_native({ query = vim.fn.getreg('""') }) end
)

map_key("n", "g]", fzf.tags_grep_cword)
