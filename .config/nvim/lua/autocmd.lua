-- store env variables in env.lua and load them on startup
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local path = vim.fn.expand("%:p:h") .. "/env.lua"
		if not vim.uv.fs_stat(path) then
			return
		end

		-- runs only after :trust, like exrc
		local content = vim.secure.read(path)
		if content then
			assert(load(content, "@" .. path))()
		end
	end,
})

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank()
	end,
})
