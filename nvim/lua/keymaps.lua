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

