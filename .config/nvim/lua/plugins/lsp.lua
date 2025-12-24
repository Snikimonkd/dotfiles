return {
    {
        "neovim/nvim-lspconfig",
        dependecies = {
            "nvim-lua/plenary.nvim",
            "Chaitanyabsprip/fastaction.nvim",
            "saghen/blink.cmp",
        },
        config = function()
            local keymap = vim.keymap

            vim.diagnostic.config(
                {
                    float = {
                        border = "rounded"
                    },
                    underline = false,
                    virtual_text = false 
                })

                keymap.set("n", "<leader>e", vim.diagnostic.open_float)
                keymap.set("n", "[d", function() vim.diagnostic.jump({ count = 1, float = true }) end)
                keymap.set("n", "]d", function() vim.diagnostic.jump({ count = -1, float = true }) end)
                keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

                -- local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
                local lsp_capabilities = require('blink.cmp').get_lsp_capabilities()


                vim.api.nvim_create_autocmd("LspAttach", {
                    callback = function(args)
                        local bufopts = { noremap = true, silent = true, buffer = args.buf }
                        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
                        vim.keymap.set("n", "K", function()
                            vim.lsp.buf.hover({ border = "rounded" })
                        end, bufopts)
                        --				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
                        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
                        vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
                        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
                        vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
                        --				vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
                        vim.keymap.set("n", "<space>of", function()
                            vim.lsp.buf.format({ async = true })
                        end, bufopts)
                    end,
                })

                vim.lsp.config("c3_lsp", {
                    capabilities = lsp_capabilities,
                    filetypes = { "c3", "c3i", "c3t", "c3l" },
                })
                vim.lsp.enable({"c3_lsp"})

                vim.lsp.config("gopls", {
                    capabilities = lsp_capabilities,
                    filetypes = { "go" },
                    settings = {
                        gopls = {
                            buildFlags = { "-tags=integration,integration_pg,integration_cassandra,integration_keydb,unit,db" },
                            analyses = {
                                append = true,
                                asmdecl = true,
                                assign = true,
                                atomic = true,
                                unreachable = true,
                                nilness = true,
                                ST1003 = true,
                                undeclaredname = true,
                                fillreturns = true,
                                nonewvars = true,
                                fieldalignment = false,
                                shadow = true,
                                unusedvariable = true,
                                unusedparams = true,
                                useany = true,
                                unusedwrite = true,
                                modernize = true,
                            },
                            codelenses = {
                                generate = true,
                                gc_details = true,
                                test = true,
                                tidy = true,
                                vendor = true,
                                regenerate_cgo = true,
                                upgrade_dependency = true,
                            },
                            hints = {
                                assignVariableTypes = false,
                                compositeLiteralFields = false,
                                compositeLiteralTypes = false,
                                constantValues = true,
                                functionTypeParameters = false,
                                parameterNames = false,
                                rangeVariableTypes = false,
                            },
                            usePlaceholders = false,
                            completeUnimported = true,
                            staticcheck = true,
                            matcher = "Fuzzy",
                            symbolMatcher = "FastFuzzy",
                            semanticTokens = false,
                            -- vulncheck = "Imports",
                        },
                    },
                })
                vim.lsp.enable({"gopls"})

                vim.lsp.config("buf_ls", {
                    capabilities = lsp_capabilities,
                    filetypes = { "proto" },
                })
                vim.lsp.enable({"buf_ls"})


                vim.lsp.config("graphql", {
                    capabilities = lsp_capabilities,
                    filetypes = { "graphql", "gql", "grpah" },
                })
                vim.lsp.enable({"graphql"})

                local function get_root_dir_name()
                    local last = ""
                    for tmp in string.gmatch(vim.fn.getcwd(), "([^" .. "/" .. "]+)") do
                        if tmp == "" then
                            goto continue
                        end
                        last = tmp
                        ::continue::
                    end
                    return last
                end


                vim.lsp.config("ols", {
                    capabilities = lsp_capabilities,
                    filetypes = { "odin" },
                    init_options = {
                        collections = {
                            {
                                name = get_root_dir_name(),
                                path = vim.fn.getcwd(),
                            },
                        },
                    },
                })
                vim.lsp.enable({"ols"})

                vim.lsp.config("zls", {
                    capabilities = lsp_capabilities,
                    filetypes = { "zig" },
                })
                vim.lsp.enable({"zls"})

                vim.lsp.config("clangd", {
                    capabilities = lsp_capabilities,
                })
                vim.lsp.enable({"clangd"})

                vim.lsp.config("pyright", {
                    capabilities = lsp_capabilities,
                })
                vim.lsp.enable({"pyright"})

                vim.lsp.config("lua_ls", {
                    capabilities = lsp_capabilities,
                    -- and lua settings work only from here
                    settings = {
                        Lua = {
                            hint = {
                                enable = false
                            },
                            -- make the language server recognize "vim" global
                            diagnostics = {
                                globals = { "vim" },
                            },
                            workspace = {
                                -- make language server aware of runtime files
                                library = {
                                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                    [vim.fn.stdpath("config") .. "/lua"] = true,
                                },
                            },
                        },
                    },
                })
                vim.lsp.enable({"lua_ls"})

            end,
        },
    }
