return {
	"sainnhe/gruvbox-material",
	priority = 1000,
	lazy = false,
	config = function()
		-- some ui stuf
		vim.opt.termguicolors = true

		-- trasnparent background
		vim.g.gruvbox_material_transparent_background = 1
		-- for same words highlighting
		vim.g.gruvbox_material_current_word = "grey background"
		-- highlight line with error
		vim.g.gruvbox_material_diagnostic_text_highlight = 1
		-- highlight error message
		vim.g.gruvbox_material_diagnostic_virtual_text = "highlighted"
		-- medium background
		vim.g.gruvbox_material_background = "medium"
		-- For better performance
		vim.g.gruvbox_material_better_performance = 1

		-- reapply overrides after every :colorscheme
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = function()
				-- boarder of floating windows
				vim.api.nvim_set_hl(0, "FloatBorder", {
					fg = "Grey",
					bg = "none",
				})
				-- title of floating windows
				vim.api.nvim_set_hl(0, "FloatTitle", {
					fg = "Grey",
					bg = "none",
				})
				-- background color none, :highlight keeps fg (nvim_set_hl would drop it)
				vim.cmd.highlight("Normal guibg=NONE")
				vim.cmd.highlight("NormalFloat guibg=NONE")
				-- dap-ui: the type column is hidden (dap-go.lua), color variable names instead;
				-- dap-ui itself only sets "hi default", so this link wins
				vim.api.nvim_set_hl(0, "DapUIVariable", { link = "Aqua" })
			end,
		})

		vim.cmd.colorscheme("gruvbox-material")
	end,
}
