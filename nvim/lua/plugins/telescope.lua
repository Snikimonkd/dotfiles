require("telescope").setup { 
    pickers = {
        live_grep = {
            additional_args = function(opts)
                return {"--hidden"}
            end
        },
    },
}

local builtin = require('telescope.builtin')
-- поиск файла по названию
vim.keymap.set('n', '<leader>F', builtin.find_files, {})
-- поиск по всем файлам
vim.keymap.set('n', '<leader>f', builtin.live_grep, {})

