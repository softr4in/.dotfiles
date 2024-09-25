return {
	"lervag/vimtex",
	lazy = false,
	init = function()
		local map = vim.keymap.set
		---- Vimtex keymaps
		map("n", "<leader>sf", "<Plug>(vimtex-view)", { desc = "Forward search (vimtex)" })
		map("n", "<leader>ll", "<Plug>(vimtex-compile)", { desc = "Toggle continuous pdf compilation (vimtex)" })
		vim.g.vimtex_view_method = "sioyek"
		-- sets luatex as the default engine w/ no need to specify luatex in file
		vim.g.vimtex_compiler_latexmk_engines = { _ = "-lualatex" }
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
		-- disable vimtex completion since nvim-cmp is being used
		vim.g.vimtex_complete_enabled = 0
		-- disable syntax conceal
		vim.g.vimtex_syntax_conceal_disable = 1
		vim.g.vimtex_quickfix_ignore_filters = {
			'Package siunitx Warning: Detected the "physics" package',
			"Overfull \\hbox",
			"Package caption Warning: \\setcaptiontype outside box or environment",
			"Package caption Warning: The option `hycap=true` will be ignored for this particular \\caption",
			"Package microtype Warning: Unable to apply patch",
		}
		-- disable quickfix open on warning
		vim.g.vimtex_quickfix_open_on_warning = 0
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
