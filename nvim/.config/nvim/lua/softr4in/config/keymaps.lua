local map = vim.keymap.set
local builtin = require("telescope.builtin")
-- local dap = require "dap"

----------------------------------------
---- Non-plugin keymaps
----------------------------------------
-- death to non-breaking spaces!
map("i", "\\u00A0", "<Space>", { noremap = true, silent = true })
map("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })
-- keymap("n", "<leader>pv", vim.cmd.Ex, { desc = "Opens netrw" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Moves selected line(s) down by one line and reselects moved text" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Moves selected line(s) up by two lines and reselects moved text" })
map("n", "J", "mzJ`z", { desc = "Joins current line with next line and keeps cursor in the same position" })
map("n", "<C-d>", "<C-d>zz", { desc = "Scrolls half a page down and centers cursor" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scrolls half a page up and centers cursor" })
map("n", "n", "nzzzv", { desc = "Moves to the next search match and centers cursor" })
map("n", "N", "Nzzzv", { desc = "Moves to the previous search match and centers cursor" })
map("x", "<leader>p", [["_dP]], { desc = "paste to replace selected text in visual mode" })
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "delete selected text w/o overwriting default register" })
map("n", "<leader>fm", vim.lsp.buf.format, { desc = "formats current buffer with its current LSP" })
map("n", "<C-n>", "<cmd>cnext<CR>zz", { desc = "Moves to next item in quickfix list and centers cursor" })
map("n", "<C-b>", "<cmd>cprev<CR>zz", { desc = "Moves to previous item in quickfix list and centers cursor" })
map("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Moves to next item in location list and centers cursor" })
map("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Moves to previous item in location list and centers cursor" })
map("n", "<leader>X", "<cmd>!chmod +x %<CR>", { desc = "Make current buffer executable", silent = true })

-- Separation of concerns; <leader>y or <leader>Y to share yanked content with other apps/people,
-- then easily return to using a separate default yank for coding
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "yanks selected text to system clipboard" })
map("n", "<leader>Y", [["+Y]], { desc = "yanks current line to system clipboard" })

---- tmux
map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "open a new tmux window silently" })

----------------------------------------
---- Plugin-specific keymaps
----------------------------------------

-- TODO: Fix luasnip telescope keymap descriptions if possible (it currently displays as <anonymous>)

---- Luasnip
-- Expand or jump in insert mode
map(
	"i",
	"<Tab>",
	"luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'",
	{ expr = true, silent = true, desc = "Expand/Jump (insert mode) (luasnip)" }
)
-- Jump backwards in insert mode
map(
	"i",
	"<S-Tab>",
	"<cmd>lua require('luasnip').jump(-1)<Cr>",
	{ silent = true, desc = "Jump backwards (insert mode) (luasnip)" }
)
-- Jump forwards in select mode
map(
	"s",
	"<Tab>",
	"<cmd>lua require('luasnip').jump(1)<Cr>",
	{ silent = true, desc = "Jump forwards (select mode) (luasnip)" }
)
-- Jump backwards in select mode
map(
	"s",
	"<S-Tab>",
	"<cmd>lua require('luasnip').jump(-1)<Cr>",
	{ silent = true, desc = "Jump backwards (select mode) (luasnip)" }
)

---- Telescope
-- map(
-- 	"n",
-- 	"<leader>ft",
-- 	":Telescope lsp_type_definitions jump_type=never<CR>",
-- 	{ desc = "Lists LSP type definitions (cursor targeted) (telescope)" }
-- )
map("n", "<leader>ft", builtin.lsp_type_definitions, { buffer = 0 })
map("n", "<leader>fd", builtin.lsp_definitions, { buffer = 0 })
-- map(
-- 	"n",
-- 	"<leader>fd",
-- 	":Telescope lsp_definitions jump_type=never<CR>",
-- 	{ desc = "Lists LSP definitions (cursor targeted) (telescope)" }
-- )
map(
	"n",
	"<leader>fr",
	":Telescope lsp_references jump_type=never<CR>",
	{ desc = "Lists LSP references (cursor targeted) (telescope)" }
)
map("n", "<leader>fi", builtin.lsp_incoming_calls, { desc = "Lists LSP incoming calls (cursor targeted) (telescope)" })
map("n", "<leader>fo", builtin.lsp_outgoing_calls, { desc = "Lists LSP outgoing calls (cursor targeted) (telescope)" })
map("n", "<leader>ff", builtin.find_files, { desc = "Find files (telescope)" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Find help (telescope)" })
map("n", "<leader>fw", builtin.grep_string, { desc = "Find current word (telescope)" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Find by grep (telescope)" })
map("n", "<leader>fD", builtin.diagnostics, { desc = "Find diagnostics (telescope)" })
map("n", "<leader>fk", ":Telescope keymaps<CR>", { desc = "Find keybindings (telescope)" })

---- Diffview
map("n", "<leader><leader>do", "<cmd>DiffviewOpen<cr>", { desc = "Open Diffview" })
map("n", "<leader><leader>dc", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" })

---- Vimtex
map("n", "<leader>sf", "<Plug>(vimtex-view)", { desc = "Forward search (vimtex)" })
map("n", "<leader>ll", "<Plug>(vimtex-compile)", { desc = "Toggle continuous pdf compilation (vimtex)" })

-- Undotree
map("n", "<leader>u", vim.cmd.UndotreeToggle)

-- ---- nvim-dap
-- map("n", "<space>b", dap.toggle_breakpoint)
-- map("n", "<space>gb", dap.run_to_cursor)
-- map("n", "<F1>", dap.continue)
-- map("n", "<F2>", dap.step_into)
-- map("n", "<F3>", dap.step_over)
-- map("n", "<F4>", dap.step_out)
-- map("n", "<F5>", dap.step_back)
-- map("n", "<F13>", dap.restart)
-- -- Eval var under cursor
-- map("n", "\\", function()
--   require("dapui").eval(nil, { enter = true })
-- end)

---- Execute line or file
map("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute the current line" })
map("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute the current file" })

---- TODO: get familiar w/ diffview and add keybindings

---- Trouble
map(
	"n",
	"<leader>T",
	":TodoTelescope keywords=TODO,HACK,FIX,WARNING<CR>",
	{ desc = "Lists special comments (trouble)" }
)
