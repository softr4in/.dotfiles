----------------------------------------
-- Non-Plugin Options only
----------------------------------------
-- NOTE: In lazy.nvim, some plugins have options that don't work when not defined under their own `config = function()`. Hence, plugin options should not be consolidated here.

---- UI
vim.wo.number = true -- displays line numbers
vim.wo.relativenumber = true -- displays relative line numbers
vim.opt.title = true -- sets title of terminal window to current filename
vim.opt.hlsearch = true -- highlights search results
vim.opt.showcmd = true -- displays partially typed commands in the bottom right
vim.opt.cmdheight = 1 -- height of command line = 1 row
vim.opt.laststatus = 2 -- shows status line at the bottom
vim.opt.scrolloff = 10 -- minimal no. of lines to keep visible when scrolling
vim.opt.guifont = "MesloLGM_Nerd_Font_Mono"
vim.opt.termguicolors = true

---- Character manipulation
vim.opt.autoindent = true -- autoindents new lines to match previous line
vim.opt.smartindent = true -- autoindents new lines based on current file's syntax
vim.opt.expandtab = true -- convert tabs to spaces
vim.scriptencoding = "utf-8" -- encoding used for scripts set to UTF-8
vim.opt.encoding = "utf-8" -- encoding for text files set to UTF-8
vim.opt.fileencoding = "utf-8" -- default file encoding set to UTF-8
vim.opt.smarttab = true -- when indenting with tabs, aligns to next tabstop
vim.opt.breakindent = true -- indents wrapped lines
vim.opt.shiftwidth = 2 -- 2 spaces per level of indentation
vim.opt.tabstop = 2 -- 2 spaces per tab character
vim.opt.wrap = true -- enables line wrap
vim.opt.linebreak = true -- line wrap only at space, tab or punctuation chars
vim.opt.textwidth = 120 -- line wrap at 120 characters
vim.opt.backspace = "start,eol,indent" -- allows backspacing over specified chars

---- Search
vim.opt.inccommand = "split" -- preview commands as you type them out before you press <CR>
vim.opt.ignorecase = true -- make search case-insensitive
vim.opt.wildignore:append({ "*/node_modules/*" }) -- ignores files and directories matching patterns
vim.opt.path:append({ "**" }) -- when searching using path, allows recursive searching

---- Others
vim.opt.clipboard:append({ "unnamed", "unnamedplus" }) -- allows copypasting btw vim and other apps
vim.opt.backup = false -- disables creation of backup files
vim.opt.shell = "zsh" -- sets default shell to fish
vim.opt.backupskip = "/tmp/*,/private/tmp/*" -- specifies directories to exclude from backup
vim.g.mapleader = " " -- sets <Leader> to space
-- vim.g.maplocalleader = " "                            -- sets <LocalLeader> to space

------ Undercurl for warnings and errors (this doesn't work on iTerm2 yet)
--vim.cmd([[let &t_Cs = "\e[4:3m"]])
--vim.cmd([[let &t_Ce = "\e[4:0m"]])
