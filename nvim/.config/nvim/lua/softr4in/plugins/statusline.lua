return {
	-- Statusline
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = {
				theme = "powerline",
			},
			sections = {
				lualine_c = {
					{
						"filename",
						-- shows relative file path rather than just filename
						path = 1,
					},
				},
			},
		})
	end,
}
