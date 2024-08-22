return {
	-- completion engine; the main plugin for completion
	"hrsh7th/nvim-cmp",
	-- lazyloads nvim-cmp only when entering insert mode
	event = "InsertEnter",
	dependencies = {
		-- source for buffer words
		"hrsh7th/cmp-buffer",
		-- source for filesystem paths
		"hrsh7th/cmp-path",
		-- source for LuaSnip completion
		"saadparwaiz1/cmp_luasnip",
		"L3MON4D3/LuaSnip", -- Must be included as a dependency for snippets to work with nvim-cmp
		-- source for neovim's builtin language server client
		"hrsh7th/cmp-nvim-lsp",
		-- adds vscode-like pictograms to neovim built-in lsp
		"onsails/lspkind.nvim",
	},
	config = function()
		local lspkind = require("lspkind")
		lspkind.init({})

		local cmp = require("cmp")
		local luasnip = require("luasnip")

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = {
				---- cmp.mapping keymaps apply implicitly in insert mode unless specified otherwise
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
				["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
				-- reveal completion menu
				["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
				-- exit completion menu
				["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
				-- select highlighted menu item; if no item is highlighted, select first item.
				-- set select to false to only select if an item is highlighted.
				["<C-CR>"] = cmp.mapping.confirm({ select = true }),
				-- <Tab> does 2 things with nvim-cmp and luasnip combined
				-- 1. luasnip's store_selection_keys w.r.t. selected text; can be commented out if ever problematic
				-- 2. If <Tab> can trigger a snippet expansion, it does. Else, if jumpable, jump forward to next node.
				["<Tab>"] = cmp.mapping(function(fallback)
					if luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
				-- Jump backwards to previous node
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			},
			-- Order of precedence for displaying of completion menu items
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
			},
		})
	end,
}
