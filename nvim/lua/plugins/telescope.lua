local builtin = require('telescope.builtin')
-- поиск файла по названию
vim.keymap.set('n', '<leader>fF', builtin.find_files, {})
-- поиск по всем файлам
vim.keymap.set('n', '<leader>f', builtin.live_grep, {})

