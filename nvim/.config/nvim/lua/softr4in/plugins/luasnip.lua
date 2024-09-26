return {
	"L3MON4D3/LuaSnip",
	config = function()
		local ls = require("luasnip")
		local map = vim.keymap.set

		-- Expand or jump in insert mode
		map(
			"i",
			"<Tab>",
			"luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'",
			{ expr = true, silent = true, desc = "Expand/Jump (insert mode) (luasnip)" }
		)
		-- Jump backwards in insert mode
		map(
			"i",
			"<S-Tab>",
			"<cmd>lua require('luasnip').jump(-1)<Cr>",
			{ silent = true, desc = "Jump backwards (insert mode) (luasnip)" }
		)
		-- Jump forwards in select mode
		map(
			"s",
			"<Tab>",
			"<cmd>lua require('luasnip').jump(1)<Cr>",
			{ silent = true, desc = "Jump forwards (select mode) (luasnip)" }
		)
		-- Jump backwards in select mode
		map(
			"s",
			"<S-Tab>",
			"<cmd>lua require('luasnip').jump(-1)<Cr>",
			{ silent = true, desc = "Jump backwards (select mode) (luasnip)" }
		)

		require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath("config") .. "/lua/softr4in/lua-snippets" })

		ls.config.setup({
			history = false,
			enable_autosnippets = true,
			-- press <Tab> with selected text in visual mode to cut and autopaste in next snippet;
			-- if this ever causes problems, you can always go back to using `d`
			store_selection_keys = "<Tab>",
			region_check_events = "InsertEnter",
			delete_check_events = "InsertLeave",
		})
	end,
}
