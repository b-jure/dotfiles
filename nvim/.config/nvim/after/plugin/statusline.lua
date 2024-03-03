--
-- Sline = { gitstr = "" }
-- local git = { br = "", df = "" }
--
-- local function newhl(hlname, guifg, ctermfg, text)
--    local custom_text_color = '%#' .. hlname .. '#'
--    local reset_color = '%*'
--    vim.cmd('hi ' .. hlname .. ' guifg=' .. guifg .. ' ctermfg=' .. ctermfg)
--    return string.format('%s%s%s', custom_text_color, text, reset_color)
-- end
--
-- local function tempfile(filename)
--    local fpath = "/tmp/" .. filename .. ".txt"
--    os.execute("touch " .. fpath)
--    return fpath
-- end
--
-- function git:branch()
--    local fpath = tempfile("branch")
--    os.execute("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n' > " ..
--                   fpath)
--    local fd = io.open(fpath, "r")
--    local branch = fd and fd:read() or ""
--    if string.len(branch) > 0 then
--        local symbol = newhl("GitBranchSymbol", "#ae81ff", 4, "  ")
--        local branchname = newhl("GitBranchName", "#74b2ff", 4, branch)
--        self.br = symbol .. branchname
--    else
--        self.br = ""
--    end
--    return self.br
-- end
--
-- function git:diff()
--    local bufnr = vim.fn.bufnr('%')
--    local path = vim.fn.bufname(bufnr)
--    if vim.fn.isdirectory(path) == 1 then return "" end
--    local fname = vim.fn.fnamemodify(path, ':t')
--    local fpath = tempfile("_gitdiff_")
--    os.execute("git diff --numstat | awk \'/" .. fname ..
--                   "/ { print $1 \"+ \" $2 \"-\" }\' > " .. fpath)
--    local fd = io.open(fpath, "r")
--    local diff = fd and fd:read() or ""
--    if string.len(diff) > 0 then
--        local i = 0;
--        self.df = ""
--        for token in string.gmatch(diff, "[^%s]+") do
--            if (i == 0) then
--                local addedlines = newhl("GitAddedLines", "#36c692", "2", token)
--                self.df = self.df .. addedlines
--            else
--                local rmdlines = newhl("GitRemovedLines", "#ff5189", "1", token)
--                self.df = self.df .. "|" .. rmdlines
--            end
--            i = i + 1
--        end
--    else
--        self.df = ""
--    end
--    return self.df
-- end
--
-- function Sline:git(refresh)
--    local path = vim.loop.cwd() .. "/.git"
--    local ok, err = vim.loop.fs_stat(path)
--    if not ok then return "" end
--    if refresh == 1 then return self.gitstr end
--    self.gitstr = git:branch() .. " " .. git:diff()
--    return self.gitstr
-- end
--
-- function Sline.curpos()
--    local tuple = vim.api.nvim_win_get_cursor(0)
--    return " " .. tostring(tuple[1]) .. ":" .. tostring(tuple[2]) .. " "
-- end
--
-- function Sline:refresh() vim.o.statusline = self:git(1) .. self.curpos() end
-- function Sline:build() vim.o.statusline = self:git(0) .. self.curpos() end
--
---- Initial build
-- vim.cmd([[
--  highlight StatusLine cterm=NONE ctermfg=White ctermbg=Black guifg=White guibg=#080808
-- ]])
--
-- vim.api.nvim_exec([[
--    autocmd CursorMoved * lua Sline:refresh()
--    autocmd CursorMovedI * lua Sline:refresh()
--    autocmd InsertLeave * lua Sline:refresh()
--    autocmd BufEnter * lua Sline:build()
-- ]], false)
-- 