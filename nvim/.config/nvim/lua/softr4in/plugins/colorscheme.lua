return {
	{
		"tjdevries/colorbuddy.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			-- load colorscheme here
			vim.cmd.colorscheme("tokyonight-storm")
		end,
	},
	{
		"folke/tokyonight.nvim",
		config = function()
			require("tokyonight").setup({
				transparent = true,
				terminal_colors = true,
				on_colors = function(colors)
					-- font color for comments
					colors.comment = "#5c6694"
					-- font color for line numbers
					colors.fg_gutter = "#6464b5"
				end,
				on_highlights = function(hl)
					hl.GitSignsAdd = { fg = "#1BB14F" }
					hl.GitSignsChange = { fg = "#0091C2" }
					hl.GitSignsDelete = { fg = "#FF4747" }
				end,
			})
		end,
	},
	{
		"scottmckendry/cyberdream.nvim",
		lazy = false,
		config = function()
			require("cyberdream").setup({
				transparent = true,
			})
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				-- enables transparent background
				disable_background = true,
			})
		end,
	},
	{
		"navarasu/onedark.nvim",
		config = function()
			require("onedark").setup({
				transparent = true,
				colors = {
					mathdollars = "#2abfd9",
				},
			})
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		config = function()
			require("kanagawa").setup({
				transparent = true,
				-- enables transparent background for line numbers
				colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
			})
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
			})
		end,
	},
}
