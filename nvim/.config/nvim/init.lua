-- ftplugin is not enabled by default in nvim, contrary to what some guides state
vim.cmd("filetype plugin on")

-- This line must be here; otherwise vimtex will use macos's default pdf viewer
vim.g.vimtex_view_method = "skim"

-- Load options.lua before lazy.lua to ensure all options, including tabstop and leader key mappings, will work correctly
require("softr4in.config.options")
require("softr4in.config.lazy")

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		require("softr4in.config.autocmds")
		require("softr4in.config.keymaps")
	end,
})

-- Use custom colorscheme w/ custom syntax highlighting for .tex files
vim.api.nvim_create_autocmd("FileType", {
	group = filetype_colorscheme,
	pattern = "tex",
	callback = function()
		vim.cmd("colorscheme catppuccin")
		vim.cmd("highlight! texMathZone guifg=#29c4d9")
		vim.cmd("highlight! texMathDelimZone guifg=#7878ff")
		vim.cmd("highlight! texMathOper guifg=#e3af46")
		vim.cmd("highlight! texDelim guifg=#e9d487")
		vim.cmd("highlight! texEnvArgName guifg=#e39fa1")
		vim.cmd("highlight! texOpt guifg=#e39fa1")
	end,
})
