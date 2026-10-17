return {
	-- file explorer
	"stevearc/oil.nvim",
	opts = {
		default_file_explorer = false,
		-- same glyphs as nvim-tree: its closed folder and the devicons default file
		columns = {
			{ "icon", directory = "\u{e5ff}", default_file = "\u{f0f6}" },
		},
		float = {
			max_width = 100,
			max_height = 100,
			-- nil means vim.o.winborder, which is empty by default
			border = "rounded",
		},
		-- popup with pending changes on save
		confirmation = {
			border = "rounded",
		},
		view_options = {
			show_hidden = true,
		},
	},
}
