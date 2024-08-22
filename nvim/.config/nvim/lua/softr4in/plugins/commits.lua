return {
	{
		-- nice ui/ux for reviewing diffs for all modified files
		"sindrets/diffview.nvim",
	},
	-- Fully featured git wrapper
	"tpope/vim-fugitive",
	-- git branch viewer
	"rbong/vim-flog",
	{
		-- Git decorations
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
}
