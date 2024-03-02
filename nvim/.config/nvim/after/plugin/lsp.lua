local lspzero = require('lsp-zero')
local lsp = lspzero.preset("recommended")

lsp.ensure_installed({ 'bashls', 'lua_ls', 'rust_analyzer', 'pylsp', 'vimls', 'clangd' })

lsp.nvim_workspace()

local cmp = require("cmp")
local cmp_select = { behaviour = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<Tab>'] = cmp.mapping.confirm({ select = true })
})

lsp.setup_nvim_cmp({ mapping = cmp_mappings })

lsp.on_attach(function(_, bufnr)
    local opts = { buffer = bufnr, remap = true }
    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>a", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>gr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>r", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

vim.diagnostic.config({ virtual_text = true })

require('lspconfig').lua_ls.setup {
    settings = {
        Lua = {
            runtime = {
                version = 'Lua 5.4',
                path = {
                    '?.lua', '?/init.lua', vim.fn.expand '~/.luarocks/share/lua/5.3/?.lua',
                    vim.fn.expand '~/.luarocks/share/lua/5.3/?/init.lua', '/usr/share/5.3/?.lua', '/usr/share/lua/5.3/?/init.lua'
                }
            },
            workspace = { library = { vim.fn.expand '~/.luarocks/share/lua/5.3', '/usr/share/lua/5.3' } }
        }
    }
}

lsp.setup()
