return {
	{
		"saghen/blink.cmp",
		dependecies = {
			"Snikimonkd/blink-cmp-go-pkgs",
		},
		--		lazy = false, -- lazy loading handled internally

		version = "v1.*",
		opts = {
			fuzzy = { implementation = "prefer_rust_with_warning" },
			keymap = {
				preset = "default",
				["<C-k>"] = { "select_prev", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },
				["<CR>"] = { "accept", "fallback" },
			},

			sources = {
				default = {
					"lsp",
					"path",
					"buffer",
					--					"go-pkgs",
				},
				providers = {
					--					["go-pkgs"] = {
					--						name = "Pkgs",
					--						module = "blink-cmp-go-pkgs",
					--						opts = {
					--							--some_option = 'some value'
					--						}, -- optional
					--					},
				},
				--				cmdline = function()
				--					local type = vim.fn.getcmdtype()
				--					-- Search forward and backward
				--					if type == "/" or type == "?" or type == ":s" then
				--						return { "buffer" }
				--					end
				--					-- Commands
				--					if type == ":" then
				--						return {}
				--					end
				--					return {}
				--				end,
			},

			completion = {
				list = {
					selection = {
						preselect = function(ctx)
							local current_line = vim.api.nvim_get_current_line()
							local current_col = vim.api.nvim_win_get_cursor(0)[2]
							local char_under_the_cursor = string.sub(current_line, current_col, current_col)
							if char_under_the_cursor == "." then
								return false
							end
							return true
						end,
						-- preselect = true,
						auto_insert = false,
					},
				},
				menu = {
					enabled = true,
					border = "rounded",
					winhighlight = "Normal:None,FloatBorder:FloatBorder,Search:None",
					scrolloff = 2,
					scrollbar = true,
					draw = {
						columns = {
							{ "label", gap = 2 },
							{ "kind", "source_name", gap = 1 },
						},
						components = {
							label = {
								text = function(ctx)
									return ctx.label
								end,
							},
							source_name = {
								text = function(ctx)
									return "[" .. ctx.source_name .. "]"
								end,
							},
						},
					},
				},

				-- docs
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 0,
					window = {
						border = "rounded",
						winhighlight = "Normal:None,FloatBorder:FloatBorder,Search:None",
					},
				},
			},
		},
		opts_extend = { "sources.default" },
	},
}
