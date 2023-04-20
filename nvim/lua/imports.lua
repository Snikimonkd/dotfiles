vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- мэнэджер плагинов
    use {'wbthomason/packer.nvim'}

    -- подсветка синтаксиса
    use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    -- Textobjects motion (functions, classes, types)
    use { 'nvim-treesitter/nvim-treesitter-textobjects' }

    -- цветовая тема
    use {'savq/melange-nvim'}
    use {'gilgigilgil/anderson.vim'}
    use {'nightsense/carbonized'}
    use {'whatyouhide/vim-gotham'}

    -- автодополнения
    use {
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
    }

    -- сигнатуры функций
    use {
        "ray-x/lsp_signature.nvim",
    }

    -- чтобы автодополнения работали
    use {
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
    }

    -- lsp
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    }

    -- дерево файлов + иконки 
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }
    
    -- скобочки
    use {
	    "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

    -- выделяет одинаковые скобочки
    use {'lukas-reineke/indent-blankline.nvim'}

    -- статус лайн внизу
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- навзания файликов сверху
    use {
        'romgrk/barbar.nvim', 
        requires = 'nvim-web-devicons'
    }

    -- поиск по файлам
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = {'nvim-lua/plenary.nvim'}
    }

    -- git
    use {'lewis6991/gitsigns.nvim'}

    -- zenmode
    use { 'folke/zen-mode.nvim'}

--    -- показывать текст ошибок в вирутальных строках
--    use {
--        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
--    }

    -- генерит табличные тесты
    use {
        'yanskun/gotests.nvim',
        ft = 'go',
        config = function()
            require('gotests').setup()
        end
    }

    -- для тестов
    use {'fatih/vim-go'}
    use {'rfratto/vim-go-testify'}

    -- запускает тесты
    use({
        "nvim-neotest/neotest",
        requires = {
            "nvim-neotest/neotest-go",
        },
        require("neotest").setup({
            adapters = {
                require("neotest-go")({
                    experimental = {
                        test_table = true,
                    },
                })
            }
        })   
    })
end)
