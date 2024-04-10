local map = vim.api

map.nvim_set_keymap("n", "<M-s>", ":MarkdownPreviewStop<CR>", { noremap = true });
map.nvim_set_keymap("n", "<M-p>", ":MarkdownPreview<CR>", { noremap = true });
