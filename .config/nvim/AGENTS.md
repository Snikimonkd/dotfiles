# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Что это

Личный конфиг Neovim (локально стоит 0.12; используется API 0.11+: `vim.lsp.config`/`vim.lsp.enable`, `vim.diagnostic.jump`, дефолтные маппинги `grr`/`gri`/…). Директория — часть репозитория dotfiles: корень git на два уровня выше (`~/dotfiles`), рядом лежат конфиги alacritty/kitty/ghostty/tmux/yabai/skhd и `.zshrc`.

`lazy-lock.json` в `.gitignore` корня — версии плагинов в git не фиксируются.

## Проверка изменений

Сборки и тестов нет. Что есть:

- `stylua --check lua/` — проверка форматирования (конфига stylua нет, используются дефолты: отступ табами). Должна проходить чисто по всем файлам.
- Lua-файлы и так форматируются stylua после сохранения через conform (`format_after_save`).
- `nvim --headless +qa` — smoke-тест загрузки (ошибки уходят в stderr); `nvim --headless "+Lazy! sync" +qa` — установить/обновить плагины.
- В lazy.nvim выключен `change_detection`, поэтому изменения в спеках плагинов подхватываются только после перезапуска nvim.

## Архитектура

### Порядок загрузки (`init.lua`)

`options` → `plugins_manager` → `autocmd` → `keymaps`. Порядок важен:
- `mapleader` (пробел) задаётся в `options.lua` до инициализации lazy.
- `keymaps.lua` на верхнем уровне делает `require("telescope.builtin")` и `vim.keymap.del` для дефолтных `grr`/`gri`/`gra`/`grn`/`grt`/`grx`, поэтому он грузится после плагинов. `gr`/`gi` переназначены на telescope (`lsp_references`/`lsp_implementations`). Удалять надо все дефолтные `gr*`: если останется хоть один, `gr` будет ждать `timeoutlen`.

### Плагины

`plugins_manager.lua` бутстрапит lazy.nvim и вызывает `require("lazy").setup("plugins")`: каждый файл в `lua/plugins/` возвращает spec (или список спеков). Плагины без серьёзной настройки собраны в `simple_plugins.lua`, остальные — по файлу на тему. У большинства спеков нет `event`/`keys`/`cmd`, так что они грузятся при старте.

Ключ зависимостей — `dependencies`. Опечатку lazy.nvim молча игнорирует (так раньше потерялся nvim-web-devicons).

### Где живут кеймапы

Они разбросаны по файлам, поэтому перед добавлением нового маппинга grep'ом проверь все места на конфликты:
- глобальные — `keymaps.lua`;
- LSP (буферные, в автокоманде `LspAttach`) и диагностика — `plugins/lsp.lua`;
- DAP — `plugins/dap-go.lua`;
- gitsigns (в `on_attach`) — `plugins/git.lua`;
- tmux-navigator (`<C-h/j/k/l>`) и leap (`s`) — `plugins/simple_plugins.lua`. Буферные маппинги на `<C-h/j/k/l>` в normal-режиме перекрывают навигацию, поэтому signature help висит на `gK`;
- `[d`/`]d` — дефолтные из nvim; float после прыжка задаётся через `jump.on_jump` в `vim.diagnostic.config` (`plugins/lsp.lua`);
- telescope (insert-режим) и blink.cmp: `<C-j>`/`<C-k>` — навигация по списку.

### LSP / completion / treesitter

- LSP настраивается через нативный `vim.lsp.config(name, {...})` + `vim.lsp.enable(...)`; nvim-lspconfig нужен только как источник дефолтных конфигов серверов. Capabilities берутся из `blink.cmp`. Inlay hints и codelens в nvim по умолчанию выключены, поэтому они включаются в `LspAttach` для всех серверов, а какие именно подсказки и линзы показывать, решают настройки сервера (`hints`/`codelenses` у gopls, `hint.enable` у lua_ls). Клавиши для запуска линз нет намеренно. mason стоит без mason-lspconfig: серверы ставятся вручную, автоустановки нет.
- Completion — blink.cmp `v1.*` (nvim-cmp не используется, несмотря на имя файла `cmp.lua`).
- nvim-treesitter на ветке `main` (новый API, без модулей `highlight`/`ensure_installed`): список языков задан в `treesitter.lua`, парсеры ставятся через `require("nvim-treesitter").install`, подсветка включается автокомандой `FileType` → `vim.treesitter.start()`.
- `queries/go/injections.scm` (`;; extends`) — инъекции SQL и JSON в строковые литералы Go. Особенности nvim 0.12: работают только захваты `@injection.content` + `injection.language` (старые `@sql`/`@json` игнорируются), а `#contains?` требует *все* перечисленные строки, для «любой из» нужен `#any-contains?`. Проверить запрос: `vim.treesitter.query.parse("go", ...)` в `nvim --clean` с парсером из `~/.local/share/nvim/site/parser/go.so`.

### Go-специфика

- Build tags `integration,integration_pg,integration_cassandra,integration_keydb,unit,db,documentation` продублированы в `buildFlags` gopls (`lsp.lua`) и в `build_flags` delve (`dap-go.lua`). Меняй их в обоих местах.
- Форматирование — conform.nvim, `format_after_save`; по умолчанию `lsp_format = "fallback"` (`default_format_opts`). Для типов файлов без своих форматтеров (`"_"`) сначала `trim_whitespace`, потом LSP (`lsp_format = "last"`): с `"fallback"` LSP там не запустился бы никогда, ведь `trim_whitespace` доступен всегда. Опции `lsp_format` из `formatters_by_ft` перекрываются тем, что возвращает `format_after_save`, поэтому он возвращает `{}`. Для Go цепочка: `gofmt` → `goimports-reviser` → `golines --max-len 120`. Отключение: `:FormatDisable` (глобально) / `:FormatDisable!` (только буфер), включение — `:FormatEnable`.
- `lua/plugins/gotests_templates/*.tmpl` — кастомные шаблоны gotests для `:GoTestAdd` (gopher.nvim): табличные тесты с `t.Parallel()`. gopher получает путь к ним абсолютным `/Users/slukash/.config/nvim/...`; при переносе файлов этот путь надо обновить.
- Тесты запускаются через vim-test (`<leader>gt`), отладка — через nvim-dap-go + nvim-dap-ui (`<leader>dt`).

### Прочее

- `autocmd.lua`: на `VimEnter`, если рядом с открытым файлом есть `env.lua` (проектные env-переменные), он выполняется через `vim.secure.read`, как `exrc`: первый раз и после каждого изменения файла nvim спрашивает разрешение (`:trust`).
- Тема — gruvbox-material с прозрачным фоном (`colors.lua`). `lualine.lua` берёт тему `lualine.themes.gruvbox-material` и обнуляет `bg`, так что смена цветовой схемы затрагивает оба файла.
- Все плавающие окна (lazy UI, диагностика, hover, blink, mason, nvim-tree, oil) используют `border = "rounded"`: при добавлении новых держись этого стиля.
- Комментарии в коде — короткие, на английском.
