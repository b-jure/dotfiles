local lsp = require("lsp-zero").preset("recommended")
--lsp.ensure_installed({})
lsp.nvim_workspace()
lsp.on_attach(function(_, bufnr)
  local opts = { buffer = bufnr, noremap = true }
  -- vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  -- vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>a", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>gr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>r", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set("n", "<leader>pa", function() vim.lsp.buf.add_workspace_folder() end, opts)
end)

vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
  },
  update_in_insert = false,
  underline = true,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup({
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
        library = {
          vim.fn.expand("~/.luarocks/share/lua/5.3"),
          "/usr/share/lua/5.3",
        },
      },
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})

lspconfig.texlab.setup({
  cmd = { "texlab", "run" },
  settings = {
    texlab = {
      auxDirectory = ".",
      bibtexFormatter = "texlab",
      build = {
        args = {
          "-pdf",
          "-interaction=nonstopmode",
          "-synctex=1",
          "%f",
        },
        executable = "latexmk",
        forwardSearchAfter = false,
        onSave = false,
      },
      chktex = {
        onEdit = false,
        onOpenAndSave = false,
      },
      diagnosticsDelay = 300,
      formatterLineLength = 80,
      forwardSearch = {
        args = {},
      },
      latexFormatter = "latexindent",
      latexindent = {
        modifyLineBreaks = false,
      },
    },
  },
})

lsp.setup()
