return {
	"nvimdev/dashboard-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	priority = 999,
	event = "VimEnter",
	lazy = false,
	opts = {
		theme = "doom",
		config = {
			week_header = {
				enable = true,
			},
		},
	},
}
