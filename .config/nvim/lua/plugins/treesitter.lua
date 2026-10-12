return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
	},
	config = function()
		local ensure_installed = {
			"bash",
			"cpp",
			"gitignore",
			"http",
			"json",
			"javascript",
			"typescript",
			"css",
			"html",
			"markdown",
			"markdown_inline",
			"proto",
			"sql",
			"yaml",
			"go",
			"c",
			"lua",
			"vim",
			"query",
			"vimdoc",
			"graphql",
			"python",
		}

		local function is_installed(lang)
			local installed = require("nvim-treesitter").get_installed()
			return vim.list_contains(installed, lang)
		end

		for _, lang in ipairs(ensure_installed) do
			if not is_installed(lang) then
				require("nvim-treesitter").install({ lang })
			end
		end

		for _, lang in ipairs(ensure_installed) do
			if not is_installed(lang) then
				vim.print("treesitter language not installed: " .. lang)
			end
		end

		-- start for installed languages
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local ft = args.match
				local lang = vim.treesitter.language.get_lang(ft)

				if is_installed(lang) then
					vim.treesitter.start()
				end
			end,
		})
	end,
}
