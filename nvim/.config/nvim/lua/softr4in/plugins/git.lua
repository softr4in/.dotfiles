return {
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			-- optional
			"sindrets/diffview.nvim",
		},
		config = function()
			local neogit = require("neogit")
			local map = vim.keymap.set

			map("n", "<leader>gs", neogit.open, { silent = true, noremap = true })
			map("n", "<leader>gc", ":Neogit commit<CR>", { silent = true, noremap = true })
			map("n", "<leader>gp", ":Neogit pull<CR>", { silent = true, noremap = true })
			map("n", "<leader>gP", ":Neogit push<CR>", { silent = true, noremap = true })
			map("n", "<leader>gb", ":Telescope git_branches<CR>", { silent = true, noremap = true })
			map("n", "<leader>gB", ":G blame<CR>", { silent = true, noremap = true })

			neogit.setup({
				-- change the default way of opening neogit
				kind = "tab",
				commit_editor = {
					kind = "tab",
					staged_diff_split_kind = "vsplit",
				},
			})
		end,
	},
	{
		-- nice ui/ux for reviewing diffs for all modified files
		"sindrets/diffview.nvim",
		config = function()
			local map = vim.keymap.set
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

			local gs = package.loaded.gitsigns
			local map = vim.keymap.set

			local function next_hunk()
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(function()
					gs.next_hunk()
				end)
				return "<Ignore>"
			end

			local function prev_hunk()
				if vim.wo.diff then
					return "[c"
				end
				vim.schedule(function()
					gs.prev_hunk()
				end)
				return "<Ignore>"
			end

			-- Jump to next hunk
			map("n", "]c", next_hunk, { expr = true })
			-- Jump to previous hunk
			map("n", "[c", prev_hunk, { expr = true })
		end,
	},
}
