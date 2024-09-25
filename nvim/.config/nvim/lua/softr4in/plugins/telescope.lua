return {
	{
		"nvim-telescope/telescope.nvim", -- Fuzzy finder
		tag = "0.1.5",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"BurntSushi/ripgrep",
		},
		config = function()
			local actions = require("telescope.actions")
			local builtin = require("telescope.builtin")
			local map = vim.keymap.set
			-- local function telescope_buffer_dir()
			-- 	return vim.fn.expand("%:p:h")
			-- end

			-- TODO: Fix luasnip telescope keymap descriptions if possible (it currently displays as <anonymous>)

			---- Telescope keymaps
			map(
				"n",
				"<leader>ft",
				":Telescope lsp_type_definitions jump_type=never<CR>",
				{ desc = "Lists LSP type definitions (cursor targeted) (telescope)" }
			)
			map(
				"n",
				"<leader>fd",
				":Telescope lsp_definitions jump_type=never<CR>",
				{ desc = "Lists LSP definitions (cursor targeted) (telescope)" }
			)
			map(
				"n",
				"<leader>fr",
				":Telescope lsp_references jump_type=never<CR>",
				{ desc = "Lists LSP references (cursor targeted) (telescope)" }
			)
			map(
				"n",
				"<leader>fi",
				builtin.lsp_incoming_calls,
				{ desc = "Lists LSP incoming calls (cursor targeted) (telescope)" }
			)
			map(
				"n",
				"<leader>fo",
				builtin.lsp_outgoing_calls,
				{ desc = "Lists LSP outgoing calls (cursor targeted) (telescope)" }
			)
			map("n", "<leader>ff", builtin.find_files, { desc = "Find files (telescope)" })
			map("n", "<leader>fh", builtin.help_tags, { desc = "Find help (telescope)" })
			map("n", "<leader>fw", builtin.grep_string, { desc = "Find current word (telescope)" })
			map("n", "<leader>fg", builtin.live_grep, { desc = "Find by grep (telescope)" })
			map("n", "<leader>fD", builtin.diagnostics, { desc = "Find diagnostics (telescope)" })
			map("n", "<leader>fk", ":Telescope keymaps<CR>", { desc = "Find keybindings (telescope)" })

			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
						},
					},
					sorting_strategy = "ascending",
					layout_strategy = "horizontal",
					layout_config = {
						height = 0.9,
						width = 0.95,
						prompt_position = "top",
					},
				},
				-- extensions = {
				-- 	file_browser = {
				-- 		theme = "dropdown",
				-- 		hijack_netrw = true, -- disables netrw and use telescope-file-browser in its place
				-- 		mappings = {
				-- 			["i"] = {}, -- your custom insert mode mappings
				-- 			["n"] = {}, -- your custom normal mode mappings
				-- 		},
				-- 	},
				-- },
			})
			-- require("telescope").load_extension("file_browser") -- This line is needed to get telescope-file-browser working
			-- vim.keymap.set("n", "<leader>e", function() -- This keybinding must be in the same buffer as the above line
			-- 	require("telescope").extensions.file_browser.file_browser({
			-- 		path = "%:p:h",
			-- 		cwd = telescope_buffer_dir(),
			-- 		respect_gitignore = false,
			-- 		hidden = true,
			-- 		grouped = true,
			-- 		initial_mode = "normal",
			-- 		layout_config = {
			-- 			height = 0.7,
			-- 			width = 0.95,
			-- 		},
			-- 	})
			-- end, { desc = "open Telescope file browser" })
		end,
	},
}
