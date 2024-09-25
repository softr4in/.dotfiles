local map = vim.keymap.set
-- local dap = require "dap"

----------------------------------------
---- Non-plugin keymaps
----------------------------------------

-- Death to non-breaking spaces!
map("i", "\\u00A0", "<Space>", { noremap = true, silent = true })
map("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })
-- map("n", "<leader>pv", vim.cmd.Ex, { desc = "Opens netrw" })
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

---- Execute line or file
map("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute the current line" })
map("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute the current file" })

---- tmux
map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "open a new tmux window silently" })

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
