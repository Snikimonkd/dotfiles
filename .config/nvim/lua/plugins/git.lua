return {
	{
		-- git signs on the left
		"lewis6991/gitsigns.nvim",
		opts = {
			current_line_blame_opts = {
				delay = 0,
			},
			-- current_line_blame = true,
			on_attach = function(bufnr)
				local gs = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gs.nav_hunk("next")
					end
				end)

				map("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gs.nav_hunk("prev")
					end
				end)

				-- Actions
				map("n", "<leader>sh", gs.stage_hunk)
				map("n", "<leader>Sh", gs.stage_buffer)
				map("v", "<leader>sh", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end)

				map("n", "<leader>rr", gs.reset_hunk)
				map("n", "<leader>Rr", gs.reset_buffer)
				map("v", "<leader>rr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end)

				map("n", "<leader>rh", gs.preview_hunk)
				map("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>")

				--	map("n", "<leader>dh", gs.diffthis)
				--	map("n", "<leader>Dh", function()
				--		gs.diffthis("~")
				--	end)
				--	-- Text object
				--	map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
			end,
		},
	},
}
