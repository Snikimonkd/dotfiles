return {
	-- formatter
	"stevearc/conform.nvim",
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				-- go = { "gofumpt" },
				go = { "gofmt", "goimports-reviser", "golines" },
				json = { "fixjson" },
				proto = { "buf" },
				-- trim_whitespace always exists, so "fallback" would never reach LSP here
				["_"] = { "trim_whitespace", lsp_format = "last" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
			--	format_on_save = function(bufnr)
			--		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			--			return
			--		else
			--			return {
			--				lsp_fallback = true,
			--			}
			--		end
			--	end,
			format_after_save = function(bufnr)
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				-- lsp_format comes from formatters_by_ft or default_format_opts
				return {}
			end,
			notify_on_error = false,
		})
		conform.formatters.golines = {
			prepend_args = { "--max-len", 120 },
		}

		vim.api.nvim_create_user_command("FormatDisable", function(args)
			if args.bang then
				vim.b.disable_autoformat = true
			else
				vim.g.disable_autoformat = true
			end
		end, {
			desc = "Disable autoformat-on-save",
			bang = true,
		})

		vim.api.nvim_create_user_command("FormatEnable", function()
			vim.b.disable_autoformat = false
			vim.g.disable_autoformat = false
		end, {
			desc = "Re-enable autoformat-on-save",
		})
	end,
}
