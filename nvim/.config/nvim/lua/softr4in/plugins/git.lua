return {
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			-- optional
			"sindrets/diffview.nvim",
		},
		config = true,
	},
	{
		-- nice ui/ux for reviewing diffs for all modified files
		"sindrets/diffview.nvim",
		config = function()
			local map = vim.keymap.set
			---- Diffview keymaps
			map("n", "<leader><leader>do", "<cmd>DiffviewOpen<cr>", { desc = "Open Diffview" })
			map("n", "<leader><leader>dc", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" })
		end,
	},
	-- Fully featured git wrapper
	"tpope/vim-fugitive",
	-- git branch viewer
	"rbong/vim-flog",
	{
		-- Git decorations
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
			})
		end,
	},
}
