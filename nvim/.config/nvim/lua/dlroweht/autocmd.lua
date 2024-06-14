-- Changes tab size for lua files
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.lua",
	command = "set tabstop=4 | set shiftwidth=4",
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
		else
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

-- Great for observing log files that get constantly updated
-- vim.o.updatetime = 2000
-- vim.api.nvim_create_autocmd({ "CursorHold", "BufRead" }, {
-- 	pattern = { "*.dbg.txt" }, -- only for debug output files
-- 	command = "checktime | call feedkeys('G')",
-- })
