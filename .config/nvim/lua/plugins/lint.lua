return {
	-- linters outside of LSP
	"mfussenegger/nvim-lint",
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			go = { "golangcilint" },
		}

		-- same build tags as gopls and delve, right after "run"
		-- args is nil when golangci-lint is not installed
		local golangci = lint.linters.golangcilint
		if golangci.args then
			table.insert(golangci.args, 2, "--build-tags=" .. require("go_tags"))
		end

		vim.api.nvim_create_autocmd("BufWritePost", {
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
