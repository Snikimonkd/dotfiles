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

-- заполнить структуру
keymap.set("n", "<leader>gf", ":GoFillStruct<CR>")

-- Clear search highlighting with <leader> and /
keymap.set('n', '<leader>/', ':nohl<CR>')


local opts = { noremap = true, silent = true }
-- запустить ближайший тест
keymap.set('n', '<leader>gt', ":GoTestifyFunc<CR>")

-- сгенерить uuid
keymap.set('n', "<leader>u", ":r! uuidgen | tr '[:upper:]' '[:lower:]'<CR>")

-- вывести все конфликты
keymap.set('n', '<leader>lc', ":GitConflictListQf<CR>")

-- переход в NORMAL на ESC в терминале
keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- открыть терминал
keymap.set('n', '<C-t>', ':terminal<CR>')

-- сплит экрана
keymap.set('n', '<leader>h', ':<C-u>split<CR>')
keymap.set('n', '<leader>g', ':<C-u>vsplit<CR>')

vim.cmd('cnoreabbrev W! w!')
vim.cmd('cnoreabbrev Q! q!')
vim.cmd('cnoreabbrev Qall! qall!')
vim.cmd('cnoreabbrev Wq wq')
vim.cmd('cnoreabbrev Wa wa')
vim.cmd('cnoreabbrev wQ wq')
vim.cmd('cnoreabbrev WQ wq')
vim.cmd('cnoreabbrev W w')
vim.cmd('cnoreabbrev Q q')
