return {
	{
		"nvim-lua/plenary.nvim",
	},
	{
		"MunifTanjim/nui.nvim",
	},
	{
		"christoomey/vim-tmux-navigator",
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
	{
		-- autopairs
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		-- usefull go things
		"olexsmir/gopher.nvim",
		opts = {
			gotests = {
				template_dir = "/Users/slukash/.config/nvim/lua/plugins/gotests_templates",
			},
		},
	},
	--	{
	--		-- http client
	--		"rest-nvim/rest.nvim",
	--		opts = {},
	--	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			exclude = {
				filetypes = { "dashboard" },
			},
			scope = {
				enabled = false,
			},
		},
	},
	{
		"ggandor/leap.nvim",
		config = function()
			require("leap").opts.safe_labels = { "s" }
			require("leap").opts.case_sensitive = false
			vim.keymap.set("n", "s", "<Plug>(leap)")
		end,
	},
	{
		-- highlight same words
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({
				delay = 100,
				filetypes_denylist = { "dashboard" },
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = {
			ui = {
				border = "rounded",
			},
		},
	},
	{
		-- run tests
		"vim-test/vim-test",
	},
	{
		"Snikimonkd/yazmp",
		-- dir = "~/go/src/gh/yazmp",
	},
}
