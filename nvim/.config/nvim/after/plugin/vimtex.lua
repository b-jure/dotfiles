vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_doc_handlers = { "vimtex#doc#handlers#textdoc" }
vim.g.tex_flavor = "latex"
vim.g.vimtex_quickfix_mode = 1
vim.g.vimtex_quickfix_ignore_filters = {
    "Missing character",
}

-- Get Neovim's window ID for switching focus from Zathura to Neovim using xdotool.
-- Only set this variable once for the current Neovim instance.
if vim.g.vim_window_id == nil then
    vim.g.vim_window_id = vim.fn.system("xdotool getactivewindow")
end

local function TexFocusVim()
    -- Give window manager time to recognize focus moved to Zathura;
    -- tweak the 200m (200 ms) as needed for your hardware and window manager.
    vim.fn.timer_start(200, function()
        -- Refocus Vim and redraw the screen
        vim.fn.system("xdotool windowfocus " .. vim.g.vim_window_id)
        vim.cmd("redraw!")
    end)
end

vim.api.nvim_create_autocmd("User", {
    pattern = "VimtexEventView",
    callback = function()
        TexFocusVim()
    end,
})
