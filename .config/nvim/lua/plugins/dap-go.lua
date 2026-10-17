vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "red" })
vim.fn.sign_define("DapStopped", { text = "→", texthl = "red" })

return {
	-- debug: everything loads on the first dap key, see keys below
	{
		"julianolf/nvim-dap-lldb",
		-- loaded as a dependency of nvim-dap
		lazy = true,
		config = function()
			local cfg = {
				configurations = {
					c3 = {
						{
							name = "Launch debugger",
							type = "lldb",
							request = "launch",
							cwd = "${workspaceFolder}",
							program = function()
								-- Build with debug symbols
								local out = vim.fn.system({ "make", "debug" })
								-- Check for errors
								if vim.v.shell_error ~= 0 then
									vim.notify(out, vim.log.levels.ERROR)
									return nil
								end
								-- Return path to the debuggable program
								return "build/bestty"
							end,
						},
					},
				},
			}

			require("dap-lldb").setup(cfg)
		end,
	},
	{
		"leoluz/nvim-dap-go",
		-- loaded as a dependency of nvim-dap
		lazy = true,
		config = function()
			require("dap-go").setup({
				delve = {
					build_flags = "-tags=" .. require("go_tags"),
				},
			})
		end,
	},
	{
		"mfussenegger/nvim-dap",
		-- adapters must be registered before the first session
		dependencies = {
			"leoluz/nvim-dap-go",
			"julianolf/nvim-dap-lldb",
		},
		-- vim.print(vim.inspect(require("dap-go").get_arguments()))
		keys = {
			{ "<leader>bp", ":DapToggleBreakpoint<CR>" },
			{
				"<leader>dk",
				function()
					require("dap.ui.widgets").hover()
				end,
			},
			{
				"<leader>sc",
				function()
					require("dap").continue()
				end,
			},
			{
				"<leader>so",
				function()
					require("dap").step_over()
				end,
			},
			{
				"<leader>si",
				function()
					require("dap").step_into()
				end,
			},
		},
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"mfussenegger/nvim-dap",
		},
		keys = {
			{
				"<leader>dt",
				function()
					-- merged into the launch config:
					-- GOMAXPROCS=1 makes go test run t.Parallel() cases one by one (-parallel
					-- defaults to GOMAXPROCS), so stepping is not interrupted by a breakpoint
					-- in a sibling case; maxStringLen is a delve launch option (default 512)
					require("dap-go").debug_test({
						env = { GOMAXPROCS = "1" },
						maxStringLen = 1000,
					})
					require("dapui").open()
				end,
			},
			{
				"<leader>do",
				function()
					require("dapui").toggle()
				end,
			},
			{
				"<leader>ds",
				function()
					require("dapui").close()
					require("dap").terminate()
				end,
			},
		},
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
				-- the expand float shifts left over the repl for lines wider than the screen
				expand_lines = false,
				wrap = false,
				layouts = {
					{
						elements = {
							{
								id = "repl",
								size = 0.3,
							},
							{
								id = "scopes",
								size = 0.7,
							},
						},
						position = "bottom",
						size = 12,
					},
				},
				render = {
					indent = 1,
					max_value_lines = 10000,
					-- hide the type column: delve sends full import paths there
					-- (gitlab.ozon.ru/.../handler.Engine), and composite values
					-- already start with the short type: handler.Engine(*mock.MockEngine) *{...}
					max_type_length = 0,
				},
			})
		end,
	},
}
