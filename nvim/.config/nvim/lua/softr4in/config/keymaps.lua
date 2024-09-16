local keymap = vim.keymap.set
local builtin = require("telescope.builtin")
-- local dap = require "dap"

----------------------------------------
---- Non-plugin keymaps
----------------------------------------
-- death to non-breaking spaces!
keymap("i", "\\u00A0", "<Space>", { noremap = true, silent = true })
keymap("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })
-- keymap("n", "<leader>pv", vim.cmd.Ex, { desc = "Opens netrw" })
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Moves selected line(s) down by one line and reselects moved text" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Moves selected line(s) up by two lines and reselects moved text" })
keymap("n", "J", "mzJ`z", { desc = "Joins current line with next line and keeps cursor in the same position" })
keymap("n", "<C-d>", "<C-d>zz", { desc = "Scrolls half a page down and centers cursor" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Scrolls half a page up and centers cursor" })
keymap("n", "n", "nzzzv", { desc = "Moves to the next search match and centers cursor" })
keymap("n", "N", "Nzzzv", { desc = "Moves to the previous search match and centers cursor" })
keymap("x", "<leader>p", [["_dP]], { desc = "paste to replace selected text in visual mode" })
keymap({ "n", "v" }, "<leader>d", [["_d]], { desc = "delete selected text w/o overwriting default register" })
keymap("n", "<leader>fm", vim.lsp.buf.format, { desc = "formats current buffer with its current LSP" })
keymap("n", "<C-n>", "<cmd>cnext<CR>zz", { desc = "Moves to next item in quickfix list and centers cursor" })
keymap("n", "<C-b>", "<cmd>cprev<CR>zz", { desc = "Moves to previous item in quickfix list and centers cursor" })
keymap("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Moves to next item in location list and centers cursor" })
keymap("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Moves to previous item in location list and centers cursor" })
keymap("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true })

-- Separation of concerns; <leader>y or <leader>Y to share yanked content with other apps/people,
-- then easily return to using a separate default yank for coding
keymap({ "n", "v" }, "<leader>y", [["+y]], { desc = "yanks selected text to system clipboard" })
keymap("n", "<leader>Y", [["+Y]], { desc = "yanks current line to system clipboard" })

---- tmux
keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "open a new tmux window silently" })

----------------------------------------
---- Plugin-specific keymaps
----------------------------------------

-- TODO: Fix luasnip telescope keymap descriptions if possible (it currently displays as <anonymous>)

---- Luasnip
-- Expand or jump in insert mode
keymap(
	"i",
	"<Tab>",
	"luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'",
	{ expr = true, silent = true, desc = "Expand/Jump (insert mode) (luasnip)" }
)
-- Jump backwards in insert mode
keymap(
	"i",
	"<S-Tab>",
	"<cmd>lua require('luasnip').jump(-1)<Cr>",
	{ silent = true, desc = "Jump backwards (insert mode) (luasnip)" }
)
-- Jump forwards in select mode
keymap(
	"s",
	"<Tab>",
	"<cmd>lua require('luasnip').jump(1)<Cr>",
	{ silent = true, desc = "Jump forwards (select mode) (luasnip)" }
)
-- Jump backwards in select mode
keymap(
	"s",
	"<S-Tab>",
	"<cmd>lua require('luasnip').jump(-1)<Cr>",
	{ silent = true, desc = "Jump backwards (select mode) (luasnip)" }
)

---- Telescope
-- keymap(
-- 	"n",
-- 	"<leader>ft",
-- 	":Telescope lsp_type_definitions jump_type=never<CR>",
-- 	{ desc = "Lists LSP type definitions (cursor targeted) (telescope)" }
-- )
keymap("n", "<leader>ft", builtin.lsp_type_definitions, { buffer = 0 })
keymap("n", "<leader>fd", builtin.lsp_definitions, { buffer = 0 })
-- keymap(
-- 	"n",
-- 	"<leader>fd",
-- 	":Telescope lsp_definitions jump_type=never<CR>",
-- 	{ desc = "Lists LSP definitions (cursor targeted) (telescope)" }
-- )
keymap(
	"n",
	"<leader>fr",
	":Telescope lsp_references jump_type=never<CR>",
	{ desc = "Lists LSP references (cursor targeted) (telescope)" }
)
keymap(
	"n",
	"<leader>fi",
	builtin.lsp_incoming_calls,
	{ desc = "Lists LSP incoming calls (cursor targeted) (telescope)" }
)
keymap(
	"n",
	"<leader>fo",
	builtin.lsp_outgoing_calls,
	{ desc = "Lists LSP outgoing calls (cursor targeted) (telescope)" }
)
keymap("n", "<leader>ff", builtin.find_files, { desc = "Find files (telescope)" })
keymap("n", "<leader>fh", builtin.help_tags, { desc = "Find help (telescope)" })
keymap("n", "<leader>fw", builtin.grep_string, { desc = "Find current word (telescope)" })
keymap("n", "<leader>fg", builtin.live_grep, { desc = "Find by grep (telescope)" })
keymap("n", "<leader>fD", builtin.diagnostics, { desc = "Find diagnostics (telescope)" })
keymap("n", "<leader>fk", ":Telescope keymaps<CR>", { desc = "Find keybindings (telescope)" })

---- Diffview
keymap("n", "<leader><leader>do", "<cmd>DiffviewOpen<cr>", { desc = "Open Diffview" })
keymap("n", "<leader><leader>dc", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" })

---- Vimtex
keymap("n", "<leader>sf", "<Plug>(vimtex-view)", { desc = "Forward search (vimtex)" })
keymap("n", "<leader>ll", "<Plug>(vimtex-compile)", { desc = "Toggle continuous pdf compilation (vimtex)" })

-- Undotree
keymap("n", "<leader>u", vim.cmd.UndotreeToggle)

-- ---- nvim-dap
-- keymap("n", "<space>b", dap.toggle_breakpoint)
-- keymap("n", "<space>gb", dap.run_to_cursor)
-- keymap("n", "<F1>", dap.continue)
-- keymap("n", "<F2>", dap.step_into)
-- keymap("n", "<F3>", dap.step_over)
-- keymap("n", "<F4>", dap.step_out)
-- keymap("n", "<F5>", dap.step_back)
-- keymap("n", "<F13>", dap.restart)
-- -- Eval var under cursor
-- keymap("n", "\\", function()
--   require("dapui").eval(nil, { enter = true })
-- end)

---- Execute line or file
keymap("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute the current line" })
keymap("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute the current file" })

---- TODO: get familiar w/ diffview and add keybindings

---- Trouble
keymap(
	"n",
	"<leader>T",
	":TodoTelescope keywords=TODO,HACK,FIX,WARNING<CR>",
	{ desc = "Lists special comments (trouble)" }
)
