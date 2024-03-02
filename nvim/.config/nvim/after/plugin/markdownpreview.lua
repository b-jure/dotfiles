local map = vim.api

map.nvim_set_keymap("n", "<M-]>", ":MarkdownPreviewStop<CR>", { noremap = true });
map.nvim_set_keymap("n", "<M-[>", ":MarkdownPreview<CR>", { noremap = true });
