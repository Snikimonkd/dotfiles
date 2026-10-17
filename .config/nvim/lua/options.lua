-- remap leader key to space
vim.g.mapleader = " "

-- amount of lines to screan edge
vim.opt.scrolloff = 7

-- for tests
vim.g["test#neovim#start_normal"] = 1

-- eng as default
vim.cmd("language en_US.utf-8")

-- show relative line nubmers
vim.wo.rnu = true

-- show absolut number for current line
vim.wo.nu = true

-- disable eof symbols
vim.api.nvim_command("set fillchars=eob:\\ ")

-- vim.api.nvim_command("set list listchars=tab:| ")
-- vim.opt.list = true
-- vim.opt.listchars = "tab:│ "
-- highlight current line
vim.wo.cursorline = true

-- copy to clipboard
vim.opt.clipboard = "unnamedplus"

-- tab = 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.smartindent = true

-- ignore case while searching
vim.opt.ignorecase = true
-- do not ignore case if upper case
vim.opt.smartcase = true

-- disable netrw
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- vim.cmd.set("noruler")

-- stop comments
vim.cmd("autocmd BufEnter * set formatoptions-=cro")
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
vim.opt.whichwrap:append("<>[]hl")

vim.o.numberwidth = 4

-- statusline always max width and on the bottom
vim.o.laststatus = 3
vim.o.showmode = false

-- just the most usefull stuf from vim kickstart
-- expand only for a whole ":" command, not inside / or :s
local function cabbrev(lhs, rhs)
	vim.keymap.set("ca", lhs, function()
		return (vim.fn.getcmdtype() == ":" and vim.fn.getcmdline() == lhs) and rhs or lhs
	end, { expr = true })
end
cabbrev("W!", "w!")
cabbrev("Q!", "q!")
cabbrev("Qall!", "qall!")
cabbrev("Wall!", "wall!")
cabbrev("Wall", "wall")
cabbrev("Wq", "wq")
cabbrev("Wa", "wa")
cabbrev("wQ", "wq")
cabbrev("WQ", "wq")
cabbrev("W", "w")
cabbrev("Q", "q")

-- column for diagnostic not moving
vim.opt.signcolumn = "yes"

-- keep undo history between sessions
vim.opt.undofile = true

-- :vsplit opens on the right
vim.opt.splitright = true

-- default border for floating windows (hover, diagnostics, oil, ...)
vim.o.winborder = "rounded"
