return {
	-- NOTE: Plugins that require little to no configuration.

	-- Browse and switch between different undo branches
	{
		"mbbill/undotree",
		config = function()
			-- Undotree
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
		end,
	},
	{
		-- easy block comment/comment out
		"numToStr/Comment.nvim",
		-- lazyloads Comment.nvim just before opening a preexisting or new buffer
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("Comment").setup()
		end,
	},
	-- {
	-- 	-- set working directory to project root
	-- 	"airblade/vim-rooter",
	-- 	config = function()
	-- 		vim.g.rooter_patterns = {
	-- 			"lua/softr4in/", -- /nvim is the root directory
	-- 			".latexmkrc",
	-- 			".git",
	-- 		}
	-- 	end,
	-- },
	{
		-- For mini.surround for quick insertion of a pair of delimiters around e.g. a word
		"echasnovski/mini.nvim",
		config = function()
			require("mini.surround").setup()
		end,
	},
	{
		-- Familiarization aid for vim keybindings
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup()
		end,
	},
	{
		-- Jump between matching words with <%>; neovim's default behaviour does it only for matching delimiters
		"andymass/vim-matchup",
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" } -- sets display method for matchparens
		end,
	},
	{
		-- Diagnostics aid
		"folke/trouble.nvim",
		config = function()
			---- Trouble
			vim.keymap.set(
				"n",
				"<leader>T",
				":TodoTelescope keywords=TODO,HACK,FIX,WARNING<CR>",
				{ desc = "Lists special comments (trouble)" }
			)
			require("trouble").setup()
		end,
	},
	{
		-- Colors for special comments and jumping to these comments
		"folke/todo-comments.nvim",
		config = function()
			require("todo-comments").setup()
		end,
	},
	{
		-- more beautiful markdown in neovim
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {},
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	},
}
