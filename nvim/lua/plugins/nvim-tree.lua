vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
    view = {
        width = 50,
    },

    diagnostics = {
        enable = true,
        show_on_dirs = true,
   },

    log = {
        enable = true,
        types = {
            diagnostics = true,
        },
    },
})
