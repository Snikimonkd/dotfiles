local actions = require('telescope.actions')

require("telescope").setup { 
    pickers = {
        live_grep = {
            additional_args = function(opts)
                return {"--hidden"}
            end
        },
    },
    defaults = {
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            },
        }
    }
}

local builtin = require('telescope.builtin')
-- поиск файла по названию
vim.keymap.set('n', '<leader>F', builtin.find_files, {})
-- поиск по всем файлам
vim.keymap.set('n', '<leader>f', builtin.live_grep, {})

