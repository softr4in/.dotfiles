return {
	{
		-- godly file explorer
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({
				view_options = {
					show_hidden = true,
				},
				keymaps = {
					["<C-h>"] = false,
					["<C-s>"] = false,
					["<C-t>"] = false,
				},
			})

			-- Open parent directory in current window
			vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })

			-- Open parent directory in floating window
			vim.keymap.set("n", "<leader><leader>e", require("oil").toggle_float)
		end,
	},
}
