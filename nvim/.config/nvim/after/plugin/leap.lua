local leap = require("leap")
leap.opts.case_sensitive = true
leap.opts.substitute_chars = { ['\r'] = '¬' }
vim.keymap.set({'n', 'x', 'o'}, 's',  '<Plug>(leap-forward)')
vim.keymap.set({'n', 'x', 'o'}, 'S',  '<Plug>(leap-backward)')
