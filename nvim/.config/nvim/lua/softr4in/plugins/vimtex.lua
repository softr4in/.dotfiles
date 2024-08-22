return {
	"lervag/vimtex",
	lazy = false,
	init = function()
		vim.g.vimtex_view_method = "sioyek"
		vim.g.vimtex_compiler_latexmk_engines = { _ = "-lualatex" } -- sets luatex as the default engine w/ no need to specify luatex in file
		vim.g.vimtex_compiler_latexmk = {
			-- do not set `out_dir = "build"`,`; it breaks inverse search. Use VIMTEX_OUTPUT_DIRECTORY instead.
			-- sets options for latexmk
			options = {
				"-shell-escape",
				"-verbose",
				"-file-line-error",
				"-synctex=1",
				"-interaction=nonstopmode",
			},
		}
		vim.env["VIMTEX_OUTPUT_DIRECTORY"] = ".build/"
		vim.g.vimtex_complete_enabled = 0 -- disable vimtex completion since nvim-cmp is being used
		vim.g.vimtex_syntax_conceal_disable = 1 -- disable syntax conceal
		vim.g.vimtex_quickfix_ignore_filters = {
			'Package siunitx Warning: Detected the "physics" package',
			"Overfull \\hbox",
			"Package caption Warning: \\setcaptiontype outside box or environment",
			"Package caption Warning: The option `hycap=true` will be ignored for this particular \\caption",
			"Package microtype Warning: Unable to apply patch",
		}
		vim.g.vimtex_quickfix_open_on_warning = 0 -- disable quickfix open on warning
		vim.api.nvim_create_augroup("VimTeX", {})
		vim.api.nvim_create_autocmd("User", {
			group = "VimTeX",
			pattern = "VimtexEventViewReverse",
			desc = "VimTeX: Return focus to vim after inverse search trigger in PDF",
			command = vim.fn.system("osascript -e 'activate application \"WezTerm\"'"),
		})
		vim.api.nvim_create_autocmd("User", {
			group = "VimTeX",
			pattern = "VimtexEventViewReverse",
			desc = "VimTeX: Center text vertically after inverse search trigger in PDF",
			command = "normal! zz",
		})
		vim.api.nvim_create_autocmd("User", {
			group = "VimTeX",
			pattern = "VimtexEventViewReverse",
			desc = "VimTeX: Send cursor to last column after inverse search trigger in PDF",
			--- @diagnostic disable-next-line: param-type-mismatch
			callback = function()
				vim.fn.cursor(".", vim.fn.col("$"))
			end,
		})
	end,
}
