---- Autocommands

-- Exits snippet on leaving insert mode; this prevents unwanted jumps, such as when I just want to insert tabspaces on
-- a new line halfway through a snippet.
local ls = require("luasnip")
vim.api.nvim_create_autocmd("CursorMovedI", {
	pattern = "*",
	callback = function(ev)
		if not ls.session or not ls.session.current_nodes[ev.buf] or ls.session.jump_active then
			return
		end

		local current_node = ls.session.current_nodes[ev.buf]
		local current_start, current_end = current_node:get_buf_position()
		current_start[1] = current_start[1] + 1 -- (1, 0) indexed
		current_end[1] = current_end[1] + 1 -- (1, 0) indexed
		local cursor = vim.api.nvim_win_get_cursor(0)

		if
			cursor[1] < current_start[1]
			or cursor[1] > current_end[1]
			or cursor[2] < current_start[2]
			or cursor[2] > current_end[2]
		then
			ls.unlink_current()
		end
	end,
})
