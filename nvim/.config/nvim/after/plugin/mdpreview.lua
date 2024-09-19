local map = vim.api

map.nvim_set_keymap("n", "<M-S>", ":MarkdownPreviewStop<CR>", { noremap = true });
map.nvim_set_keymap("n", "<M-s>", ":MarkdownPreview<CR>", { noremap = true });
