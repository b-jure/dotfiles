local lsp = require("lsp-zero").preset("recommended")
lsp.ensure_installed({ "bashls", "lua_ls", "vimls", "clangd" })
lsp.nvim_workspace()

require('luasnip.loaders.from_vscode').lazy_load()

vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

local cmp = require("cmp")
local luasnip = require("luasnip")
local cmp_select_ops = { behaviour = cmp.SelectBehavior.Select }

cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end
    },
    sources = {
      {name = 'path'},
      {name = 'nvim_lsp', keyword_length = 1},
      {name = 'buffer', keyword_length = 3},
      {name = 'luasnip', keyword_length = 2},
    },
    window = {
      documentation = cmp.config.window.bordered()
    },
    formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
        local menu_icon = {
          nvim_lsp = 'λ',
          luasnip = '⋗',
          buffer = '',
          path = '',
        }
        item.menu = menu_icon[entry.source.name]
        return item
      end,
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select_ops),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select_ops),
        ["<C-e>"] = cmp.mapping.confirm({ select = true }),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-r>'] = cmp.mapping.abort(),
        ['<C-f>'] = cmp.mapping(function(fallback)
          if luasnip.jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, {'i', 's'}),
        ['<C-b>'] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, {'i', 's'}),
    }
})

lsp.on_attach(function(_, bufnr)
	local opts = { buffer = bufnr, noremap = true }
	-- vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	-- vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "<leader>A", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "<leader>gr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>r", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
	vim.keymap.set("n", "<leader>pa", function() vim.lsp.buf.add_workspace_folder() end, opts)
end)

vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    float = {
        border = 'rounded',
        source = 'always',
    },
    update_in_insert = false,
    underline = true,
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {border = 'rounded'}
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {border = 'rounded'}
)

require("lspconfig").lua_ls.setup({
	autostart = false,
	settings = {
		Lua = {
			runtime = {
				version = "Lua 5.4",
				path = {
					"?.lua",
					"?/init.lua",
					vim.fn.expand("~/.luarocks/share/lua/5.3/?.lua"),
					vim.fn.expand("~/.luarocks/share/lua/5.3/?/init.lua"),
					"/usr/share/5.3/?.lua",
					"/usr/share/lua/5.3/?/init.lua",
				},
			},
			workspace = {
				library = { vim.fn.expand("~/.luarocks/share/lua/5.3"), "/usr/share/lua/5.3" },
			},
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

require("lspconfig").clangd.setup({
	cmd = { "clangd", "--enable-config", "--malloc-trim", "--query-driver=/usr/bin/gcc" },
	autostart = false,
})

lsp.setup()
