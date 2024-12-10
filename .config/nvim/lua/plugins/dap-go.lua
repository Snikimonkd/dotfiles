vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "red" })
vim.fn.sign_define("DapStopped", { text = "→", texthl = "red" })
return {
	-- debug
	{
		"leoluz/nvim-dap-go",
		config = function()
			require("dap-go").setup({
				delve = {
					args = {
						["max-string-len"] = 1000,
					},
				},
			})
		end,
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
		},
		config = function()
			-- vim.print(vim.inspect(require("dap-go").get_arguments()))
			require("dap").set_log_level("debug")

			vim.keymap.set("n", "<leader>bp", ":DapToggleBreakpoint<CR>")

			vim.keymap.set("n", "<leader>dk", ":lua require('dap.ui.variables').hover()<CR>")
			vim.keymap.set("n", "<leader>sc", require("dap").continue)
			vim.keymap.set("n", "<leader>so", require("dap").step_over)
			vim.keymap.set("n", "<leader>si", require("dap").step_into)
		end,
	},
	{
		dependencies = {
			"nvim-neotest/nvim-nio",
			"mfussenegger/nvim-dap",
		},
		"rcarriga/nvim-dap-ui",
		config = function()
			require("dapui").setup({
				controls = {
					element = "repl",
					enabled = true,
					icons = {
						disconnect = "",
						pause = "",
						play = "",
						run_last = "",
						step_back = "",
						step_into = "",
						step_out = "",
						step_over = "",
						terminate = "",
					},
				},
				expand_lines = true,
				layouts = {
					{
						elements = {
							{
								id = "repl",
								size = 0.5,
							},
						},
						position = "bottom",
						size = 4,
					},
					{
						elements = {
							{
								id = "scopes",
								size = 0.5,
							},
						},
						position = "bottom",
						size = 8,
					},
				},
				render = {
					indent = 1,
					max_value_lines = 10000,
					max_type_length = 10000,
				},
			})

			vim.keymap.set("n", "<leader>dt", function()
				require("dap-go").debug_test()
				require("dapui").open()
			end)

			vim.keymap.set("n", "<leader>do", require("dapui").toggle)
			vim.keymap.set("n", "<leader>ds", function()
				require("dapui").close()
				require("dap").terminate()
			end)
		end,
	},
}
