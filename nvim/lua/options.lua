-- количество строк до края экрана
vim.o.scrolloff=7

-- нумерация строк относительно курсора
vim.wo.rnu = true

-- номер текущей строки - абсолютный
vim.wo.nu = true

-- выделить строку на которой находится курсор
vim.wo.cul = true

-- копировать в буфер обмена
vim.opt.clipboard = 'unnamedplus'

-- настройки для цветовой темы
vim.opt.termguicolors = true
-- require("gruvbox").setup({
--     inverse = true, -- invert background for search, diffs, statuslines and errors
--     contrast = "soft", -- can be "hard", "soft" or empty string
--     palette_overrides = {},
-- })

-- прозрачный задний фон
vim.g.gruvbox_material_transparent_background = 1
-- выделяет все слова как то на котором курсор
vim.g.gruvbox_material_current_word = 'grey background'
-- выделять красным строку на которой ошибка
vim.g.gruvbox_material_diagnostic_text_highlight = 1
-- выделять красным текст ошибки сбоку
vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
-- мягкость заднего фона
vim.g.gruvbox_material_background = 'soft'
-- For better performance
vim.g.gruvbox_material_better_performance = 1


vim.cmd.colorscheme 'gruvbox-material'
-- vim.cmd.colorscheme 'gruvbox'
-- vim.cmd.colorscheme 'melange'
-- vim.cmd.colorscheme 'alduin'
-- vim.cmd.colorscheme 'anderson'
-- vim.cmd.colorscheme 'carbonized-dark'
-- vim.cmd.colorscheme 'focus'
-- vim.cmd.colorscheme 'gotham'
-- vim.cmd.colorscheme 'hacker'
-- vim.cmd.colorscheme 'jelly'
-- vim.cmd.colorscheme 'mount-gery'
-- vim.cmd.colorscheme 'mount'



-- темная тема
-- vim.o.background = "dark" -- or "light" for light mode

-- количество табов = 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.smartindent = true

-- игнорировать регистр при поиске
vim.opt.ignorecase = true
-- если набирать с заглавной буквы то регистр учитывается
vim.opt.smartcase = true

-- колонка с иконками и гитом не прыгает
vim.opt.signcolumn = "yes"

-- не продолжать комментарии
vim.cmd("autocmd BufEnter * set formatoptions-=cro")
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")

-- ищет подсказки в незаимпорченных пакетах
vim.g.go_gopls_complete_unimported = 1

-- Highlight some more stuff
vim.g.go_highlight_types = 1
vim.g.go_highlight_fields = 1
vim.g.go_highlight_functions = 1
vim.g.go_highlight_function_calls = 1
vim.g.go_highlight_operators = 1
vim.g.go_highlight_extra_types = 1

-- видимость картинки на заднем плане
vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
