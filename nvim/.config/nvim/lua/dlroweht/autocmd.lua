vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")

-- Changes tab size for lua files
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.lua", "*.org" },
	command = "set tabstop=4 | set shiftwidth=4",
})

vim.o.updatetime = 2000
vim.api.nvim_create_autocmd({ "CursorHold", "BufRead" }, {
	pattern = { "*.dbg.txt" }, -- only for debug output files
	command = "checktime | call feedkeys('G')",
})

-- Disables settings and lsp depending on the size of the file
vim.api.nvim_create_autocmd({ "BufReadPre" }, {
	pattern = "*",
	callback = function()
		local limit = 1000000 -- 1MB
		local currbuf = vim.api.nvim_get_current_buf()
		local bufname = vim.api.nvim_buf_get_name(currbuf)
		local ok, stats = pcall(vim.loop.fs_stat, bufname)

		if ok and stats and (stats.size > limit) then
			local clients = vim.lsp.get_active_clients({ bufnr = currbuf })
			if clients then
				vim.lsp.stop_client(clients)
			end
			vim.opt_local.spell = false
			vim.b.bigbuf = true
			vim.keymap.set("n", "gd", "<C-]>", { noremap = true, silent = true })
		else
			if not ok then
				error(stats)
			end
			vim.b.bigbuf = false
		end
	end,
})

-- Enable lsp if file size is small enough
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "*",
	callback = function()
		if not vim.b.bigbuf then
			vim.cmd("LspStart")
		end
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "*.c", "*.h" },
	callback = function()
		vim.keymap.set("n", "gd", "<C-]>", { silent = true, noremap = true })
	end,
})

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
