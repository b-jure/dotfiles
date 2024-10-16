require("luasnip.loaders.from_vscode").lazy_load()

local cmp = require("cmp")
local luasnip = require("luasnip")
local cmp_select_ops = { behaviour = cmp.SelectBehavior.Select }
local kind_icons = {
	article = "󰧮",
	book = "",
	incollection = "󱓷",
	Function = "󰊕",
	Constructor = "",
	Text = "󰦨",
	Method = "",
	Field = "󰅪",
	Variable = "󱃮",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "󰚯",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "󰌁",
	-- Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	-- spell = "",
	-- EnumMember = "",
	Constant = "󰀫",
	Struct = "",
	-- Struct = "",
	Event = "",
	Operator = "󰘧",
	TypeParameter = "",
}

cmp.setup({
	completion = {
		completeopt = "menu,noselect",
		keyword_length = 1,
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select_ops),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select_ops),
		["<C-e>"] = cmp.mapping.confirm({ select = false }),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-r>"] = cmp.mapping.abort(),
	}),
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, item)
			item.kind = string.format("%s", kind_icons[item.kind])
			item.menu = ({
				vimtex = item.menu,
				luasnip = "[Snippet]",
				nvim_lsp = "[LSP]",
				buffer = "[Buffer]",
				spell = "[Spell]",
				orgmode = "[Org]",
				cmdline = "[CMD]",
				path = "[Path]",
			})[entry.source_name]
			return item
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "vimtex" },
		{ name = "orgmode" },
		{ name = "buffer", keyword_length = 3 },
		{
			name = "spell",
			keyword_length = 4,
			option = {
				keep_all_entries = false,
				enable_in_context = function()
					return true
				end,
			},
		},
		{ name = "path" },
	},
	confirm_opts = {
		select = false,
	},
	view = {
		entries = "custom",
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	performance = {
		trigger_debounce_time = 500,
		throttle = 550,
		fetching_timeout = 80,
	},
})

--cmp.setup.cmdline("/", {
--	mapping = cmp.mapping.preset.cmdline(),
--	sources = {
--		{ name = "buffer" },
--	},
--})
--
--cmp.setup.cmdline(":", {
--    mapping = cmp.mapping.preset.cmdline(),
--    sources = {
--        {name = "path"},
--        {name = "cmdline"}
--    }
--})
