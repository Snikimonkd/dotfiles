local cmp = require('cmp')

local luasnip = require('luasnip')

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    -- Load sources, see: https://github.com/topics/nvim-cmp
    sources = {
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'buffer' },
        { name = 'luasnip' },
    },

    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
}

cmp.event:on(
'confirm_done',
require('nvim-autopairs.completion.cmp').on_confirm_done()
)

