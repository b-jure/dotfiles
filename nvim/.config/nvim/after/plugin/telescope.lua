local builtin = require('telescope.builtin')

vim.keymap.set('n', '<C-p>', builtin.find_files,
               { noremap = true, silent = true })

vim.keymap.set('n', '<leader>pb', builtin.buffers,
               { desc = '[pb] Find existing buffers' })

vim.keymap.set('n', '<leader>ph', builtin.help_tags,
               { desc = '[ph] Sarch help tags' })

vim.keymap.set('n', '<leader>pd', builtin.diagnostics,
               { desc = '[pd] Search diagnostics' })

vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep: ") })

end)
