return {
	"L3MON4D3/LuaSnip",
	config = function()
		local ls = require("luasnip")

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
