return {
	-- file explorer
	"stevearc/oil.nvim",
	opts = {
		default_file_explorer = false,
		-- same glyphs as nvim-tree: its closed folder and the devicons default file
		columns = {
			{ "icon", directory = "\u{e5ff}", default_file = "\u{f0f6}" },
		},
		-- border comes from vim.o.winborder
		float = {
			-- same ratios as the nvim-tree float
			max_width = 0.5,
			max_height = 0.8,
		},
		view_options = {
			show_hidden = true,
		},
	},
}
