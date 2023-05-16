local keymap = vim.keymap 
-- просто открыть дерево
keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>")
-- открыть дерево на текущем файлу
keymap.set("n", "<leader>T", ":NvimTreeFindFile<CR>")


-- закрыть текущий буфер
keymap.set("n", "<leader>c", ":BufferClose<CR>")
-- предыдущий буфер
keymap.set("n", "<leader>p", ":BufferPrevious<CR>")
-- следующий буфер
keymap.set("n", "<leader>n", ":BufferNext<CR>")
-- подвинуть буфер влево
keymap.set("n", "<leader>mp", ":BufferMovePrevious<CR>")
-- подвинуть буфер впарво 
keymap.set("n", "<leader>mn", ":BufferMoveNext<CR>")

-- запустить зен мод
keymap.set("n", "<leader>z", ":ZenMode<CR>")


-- Clear search highlighting with <leader> and /
keymap.set('n', '<leader>/', ':nohl<CR>')


local opts = { noremap = true, silent = true }
-- запустить ближайший тест
keymap.set('n', '<leader>gt', function() require('neotest').run.run() end, opts)

-- показать вывод тестов
keymap.set('n', '<leader>r', function() require('neotest').output_panel.open() end, opts)

-- сгенерить uuid
keymap.set('n', "<leader>u", ":r! uuidgen | tr '[:upper:]' '[:lower:]'<CR>")

-- вывести все конфликты
keymap.set('n', '<leader>lc', ":GitConflictListQf<CR>")

