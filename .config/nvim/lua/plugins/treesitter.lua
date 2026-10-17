return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	-- queries are updated with the plugin, parsers must follow,
	-- otherwise highlighting fails with "Invalid field name"
	build = ":TSUpdate",
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

		-- async, already installed languages are skipped
		require("nvim-treesitter").install(ensure_installed)

		-- start for installed languages
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local ft = args.match
				local lang = vim.treesitter.language.get_lang(ft)

				if is_installed(lang) then
					vim.treesitter.start(args.buf, lang)
				end
			end,
		})

		-- textobjects: a/i + f(unction), c(lass: struct/interface in go), a(rgument)
		require("nvim-treesitter-textobjects").setup({
			select = {
				-- jump forward to the next object if the cursor is not inside one
				lookahead = true,
			},
		})

		local select = require("nvim-treesitter-textobjects.select")
		for keys, query in pairs({
			af = "@function.outer",
			["if"] = "@function.inner",
			ac = "@class.outer",
			ic = "@class.inner",
			aa = "@parameter.outer",
			ia = "@parameter.inner",
		}) do
			vim.keymap.set({ "x", "o" }, keys, function()
				select.select_textobject(query, "textobjects")
			end)
		end

		-- ]f [f: next/previous function start
		local move = require("nvim-treesitter-textobjects.move")
		vim.keymap.set({ "n", "x", "o" }, "]f", function()
			move.goto_next_start("@function.outer", "textobjects")
		end)
		vim.keymap.set({ "n", "x", "o" }, "[f", function()
			move.goto_previous_start("@function.outer", "textobjects")
		end)
	end,
}
