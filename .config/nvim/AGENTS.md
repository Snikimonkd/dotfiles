# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Что это

Личный конфиг Neovim (локально стоит 0.12; используется API 0.11+: `vim.lsp.config`/`vim.lsp.enable`, `vim.diagnostic.jump`, дефолтные маппинги `grr`/`gri`/…). Директория — часть репозитория dotfiles: корень git на два уровня выше (`~/dotfiles`), рядом лежат конфиги alacritty/kitty/ghostty/tmux/yabai/skhd и `.zshrc`.

`lazy-lock.json` хранится в git (раньше был в `.gitignore` корня): после неудачного обновления плагинов откатывайся через `:Lazy restore`.

## Проверка изменений

Сборки и тестов нет. Что есть:

- `stylua --check lua/` — проверка форматирования (конфига stylua нет, используются дефолты: отступ табами). Должна проходить чисто по всем файлам.
- Lua-файлы и так форматируются stylua после сохранения через conform (`format_after_save`).
- `nvim --headless +qa` — smoke-тест загрузки (ошибки уходят в stderr); `nvim --headless "+Lazy! sync" +qa` — установить/обновить плагины.
- В песочнице Claude Code запись в `~/.local/share` и `~/.local/state` закрыта, поэтому полный smoke-тест гоняй на копии: `cp -R ~/.local/share/nvim/lazy` во временный `XDG_DATA_HOME/nvim/lazy` (симлинки lazy не принимает), плюс `XDG_CONFIG_HOME=~/dotfiles/.config`, временные `XDG_STATE_HOME`/`XDG_CACHE_HOME`. Ошибка `EMFILE` из `vim/_watch.lua` при старте LSP — следствие песочницы, а не конфига: она воспроизводится и в `nvim --clean`.
- В lazy.nvim выключен `change_detection`, поэтому изменения в спеках плагинов подхватываются только после перезапуска nvim (в 0.12 есть `:restart`).

## Архитектура

### Порядок загрузки (`init.lua`)

`options` → `plugins_manager` → `autocmd` → `keymaps`. Порядок важен:
- `mapleader` (пробел) задаётся в `options.lua` до инициализации lazy.
- `keymaps.lua` на верхнем уровне делает `require("telescope.builtin")` и `vim.keymap.del` для дефолтных `grr`/`gri`/`gra`/`grn`/`grt`/`grx`, поэтому он грузится после плагинов. `gr`/`gi` переназначены на telescope (`lsp_references`/`lsp_implementations`). Удалять надо все дефолтные `gr*`: если останется хоть один, `gr` будет ждать `timeoutlen`.

### Плагины

`plugins_manager.lua` бутстрапит lazy.nvim и вызывает `require("lazy").setup("plugins")`: каждый файл в `lua/plugins/` возвращает spec (или список спеков). Плагины без серьёзной настройки собраны в `simple_plugins.lua`, остальные — по файлу на тему. Большинство спеков грузится при старте. Лениво грузятся: стек dap (по `keys`, см. ниже), gopher (`ft = "go"`), rest.nvim (`ft = "http"`, поэтому `vim.g.rest_nvim` задаётся в `init`) и vim-test (`cmd`). Telescope ленивым сделать нельзя: `keymaps.lua` требует его на верхнем уровне, а ui-select подменяет `vim.ui.select` при загрузке. Lazy-загрузку oil и nvim-tree их авторы не рекомендуют.

Ключ зависимостей — `dependencies`. Опечатку lazy.nvim молча игнорирует (так раньше потерялся nvim-web-devicons).

### Где живут кеймапы

Они разбросаны по файлам, поэтому перед добавлением нового маппинга grep'ом проверь все места на конфликты:
- глобальные — `keymaps.lua`;
- LSP (буферные, в автокоманде `LspAttach`) и диагностика — `plugins/lsp.lua`;
- DAP — `plugins/dap-go.lua`, в `keys` спеков: так клавиши и грузят dap. `nvim-dap` зависит от `nvim-dap-go` и `nvim-dap-lldb`, чтобы адаптеры регистрировались при любой первой dap-клавише;
- textobjects treesitter (`af`/`if`, `ac`/`ic`, `aa`/`ia`, `]f`/`[f`) — `plugins/treesitter.lua`;
- gitsigns (в `on_attach`) — `plugins/git.lua`;
- tmux-navigator (`<C-h/j/k/l>`) и leap (`s`) — `plugins/simple_plugins.lua`. Буферные маппинги на `<C-h/j/k/l>` в normal-режиме перекрывают навигацию, поэтому signature help висит на `gK`;
- `[d`/`]d` — дефолтные из nvim; float после прыжка задаётся через `jump.on_jump` в `vim.diagnostic.config` (`plugins/lsp.lua`);
- telescope (insert-режим) и blink.cmp: `<C-j>`/`<C-k>` — навигация по списку.

### LSP / completion / treesitter

- LSP настраивается через нативный `vim.lsp.config(name, {...})` + один общий `vim.lsp.enable({...})`; nvim-lspconfig нужен только как источник дефолтных конфигов серверов, поэтому в `vim.lsp.config` пишутся только отличия от его дефолтов. Capabilities выставляет сам blink.cmp через `vim.lsp.config("*", ...)` (`plugin/blink-cmp.lua`), передавать их серверам не нужно. `K` — дефолтный hover из nvim. `<space>of` форматирует через conform, теми же форматтерами, что и при сохранении. Inlay hints и codelens в nvim по умолчанию выключены, поэтому они включаются в `LspAttach` для всех серверов, а какие именно подсказки и линзы показывать, решают настройки сервера (`hints`/`codelenses` у gopls, `hint.enable`/`codeLens.enable` у lua_ls). Дефолтный конфиг lua_ls из nvim-lspconfig включает и то и другое, поэтому у lua_ls они выключены явно, иначе в Lua-файлах висят строки `N references` и `...` (последняя — линза, которую lua_ls не смог посчитать). Клавиши для запуска линз нет намеренно. mason стоит без mason-lspconfig: серверы ставятся вручную, автоустановки нет.
- Completion — blink.cmp `v1.*` (nvim-cmp не используется, несмотря на имя файла `cmp.lua`); `signature.enabled` показывает сигнатуру при наборе аргументов.
- `vim.ui.select` (меню code action и т. п.) — пикер telescope через telescope-ui-select.
- nvim-treesitter на ветке `main` (новый API, без модулей `highlight`/`ensure_installed`): список языков задан в `treesitter.lua`, парсеры ставятся через `require("nvim-treesitter").install` (уже установленные он пропускает и не обновляет), подсветка включается автокомандой `FileType` → `vim.treesitter.start()`. Запросы обновляются вместе с плагином, а парсеры — только через `:TSUpdate`; он стоит в `build` спека. Если парсер отстал от запросов, подсветка падает с `Query error … Invalid field name` (так было с `proto` в превью telescope).
- `queries/go/injections.scm` (`;; extends`) — инъекции SQL и JSON в строковые литералы Go. Особенности nvim 0.12: работают только захваты `@injection.content` + `injection.language` (старые `@sql`/`@json` игнорируются), а `#contains?` требует *все* перечисленные строки, для «любой из» нужен `#any-contains?`. Проверить запрос: `vim.treesitter.query.parse("go", ...)` в `nvim --clean` с парсером из `~/.local/share/nvim/site/parser/go.so`.

### Go-специфика

- Build tags `integration,integration_pg,integration_cassandra,integration_keydb,unit,db,documentation` живут в одном месте — `lua/go_tags.lua`. Оттуда их берут `buildFlags` gopls (`lsp.lua`), `build_flags` delve (`dap-go.lua`) и `--build-tags` golangci-lint (`lint.lua`).
- Линтинг — nvim-lint с golangci-lint на `BufWritePost` (`plugins/lint.lua`); результаты попадают в обычную диагностику.
- Форматирование — conform.nvim, `format_after_save`; по умолчанию `lsp_format = "fallback"` (`default_format_opts`). Для типов файлов без своих форматтеров (`"_"`) сначала `trim_whitespace`, потом LSP (`lsp_format = "last"`): с `"fallback"` LSP там не запустился бы никогда, ведь `trim_whitespace` доступен всегда. Опции `lsp_format` из `formatters_by_ft` перекрываются тем, что возвращает `format_after_save`, поэтому он возвращает `{}`. Для Go цепочка: `gofmt` → `goimports-reviser` → `golines --max-len 120`; `gofumpt` в gopls выключен, чтобы ручное форматирование не расходилось с этой цепочкой. Отключение: `:FormatDisable` (глобально) / `:FormatDisable!` (только буфер), включение — `:FormatEnable`.
- `lua/plugins/gotests_templates/*.tmpl` — кастомные шаблоны gotests для `:GoTestAdd` (gopher.nvim): табличные тесты с `t.Parallel()`. Путь к ним строится от `vim.fn.stdpath("config")`.
- Тесты запускаются через vim-test (`<leader>gt`), отладка — через nvim-dap-go + nvim-dap-ui (`<leader>dt`). `<leader>dt` передаёт в `debug_test` дополнения к конфигу запуска: `env = { GOMAXPROCS = "1" }` (у `go test` `-parallel` по умолчанию равен `GOMAXPROCS`, так что кейсы с `t.Parallel()` идут по одному и не прерывают шаг брейкпоинтом в соседнем кейсе — иначе delve пишет «Unable to step while the previous step is interrupted by a breakpoint», и выручает только continue) и `maxStringLen = 1000` (опция запуска delve, по умолчанию 512). `delve.args` в `setup` nvim-dap-go — это список флагов CLI `dlv dap`, а не опции запуска.
- delve присылает в поле `type` полные пути импорта (`gitlab.ozon.ru/…/handler.Engine`), и настройки, чтобы их укоротить, у него нет: `getTypeIfSupported` в `service/dap/server.go` всегда отдаёт полное имя. Поэтому колонка типа в dap-ui скрыта (`render.max_type_length = 0`): короткий тип у составных значений delve и так пишет в начале `value`. Чтобы строки не были одноцветными, имена переменных покрашены: `DapUIVariable` → `Aqua` в автокоманде `ColorScheme` в `colors.lua` (dap-ui задаёт свои группы через `hi default` и её не перекрывает). Отладку в песочнице Claude Code не запустить: debugserver не стартует (`stub exited while waiting for connection`).
- `switchbuf` у nvim-dap стандартный (`uselast`, своя функция была и её убрали намеренно). Поэтому если шагнуть, стоя в окне dap-ui, а предыдущим окном был REPL, nvim-dap откроет кадр в окне REPL, dap-ui вернёт туда свой буфер, и будет предупреждение «Adapter reported frame in buf N … Invalid cursor line: out of range». Это не баг конфига: шагай из окна с кодом.

### Прочее

- `autocmd.lua`: на `VimEnter`, если рядом с открытым файлом есть `env.lua` (проектные env-переменные), он выполняется через `vim.secure.read`, как `exrc`: первый раз и после каждого изменения файла nvim спрашивает разрешение (`:trust`).
- Тема — gruvbox-material с прозрачным фоном (`colors.lua`). `lualine.lua` берёт тему `lualine.themes.gruvbox-material` и обнуляет `bg`, так что смена цветовой схемы затрагивает оба файла.
- Все плавающие окна — со скруглённой рамкой. Базу задаёт `vim.o.winborder = "rounded"` (`options.lua`): hover, signature, float диагностики, oil и окно сигнатуры blink берут рамку из него. Плагины со своими настройками (lazy UI, blink menu/docs, mason, nvim-tree, telescope) настроены на `"rounded"` явно. Новые окна держи в том же стиле. У telescope лишней рамки от `winborder` не будет: plenary ставит своим окнам `border = "none"` явно.
- `options.lua`: `undofile`, `splitright`; `autocmd.lua`: подсветка скопированного (`vim.hl.on_yank`).
- Комментарии в коде — короткие, на английском.
