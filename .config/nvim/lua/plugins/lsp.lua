return {
	--    {
	--        "lukas-reineke/lsp-format.nvim",
	--        config = function()
	--            require("lsp-format").setup({})
	--            vim.api.nvim_create_autocmd('LspAttach', {
	--                callback = function(args)
	--                    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
	--                    require("lsp-format").on_attach(client, args.buf)
	--                end,
	--            })
	--        end
	--    },
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- sets capabilities for all servers via vim.lsp.config("*")
			"saghen/blink.cmp",
		},
		config = function()
			local keymap = vim.keymap

			-- float border comes from vim.o.winborder
			vim.diagnostic.config({
				-- show float after default [d ]d [D ]D jumps
				jump = {
					on_jump = function(_, bufnr)
						vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor", focus = false })
					end,
				},
				underline = false,
				virtual_text = true,
			})

			keymap.set("n", "<leader>e", vim.diagnostic.open_float)
			keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

			-- K is the default vim.lsp.buf.hover()
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufopts = { noremap = true, silent = true, buffer = args.buf }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
					--				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
					-- not <C-k>: it is tmux-navigator up
					vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, bufopts)
					vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
					vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
					vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
					--				vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
					-- same formatters as on save
					vim.keymap.set("n", "<space>of", function()
						require("conform").format({ async = true })
					end, bufopts)

					-- off by default in nvim, kinds are chosen in server settings (gopls hints/codelenses)
					vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
					vim.lsp.codelens.enable(true, { bufnr = args.buf })
				end,
			})

			-- only overrides of nvim-lspconfig defaults below

			vim.lsp.config("c3_lsp", {
				filetypes = { "c3", "c3i", "c3t", "c3l" },
			})

			vim.lsp.config("gopls", {
				-- gomod: tidy/vendor/upgrade_dependency codelenses live in go.mod
				filetypes = { "go", "gomod" },
				settings = {
					gopls = {
						-- no gofumpt: go is formatted by conform (gofmt chain)
						buildFlags = { "-tags=" .. require("go_tags") },
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
							-- "run test" shows only "N / N tests failed", use <leader>gt (vim-test)
							test = false,
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

			--            vim.api.nvim_create_autocmd("BufWritePre", {
			--                pattern = "*.go",
			--                callback = function()
			--                    local clients = vim.lsp.get_clients()
			--                    for _, cli in ipairs(clients) do
			--                        local method = "textDocument/formatting"
			--                        local handler = function (err, result, ctx)
			--                            if err ~= nil then
			--                                vim.lsp.log.error(string.format("lsp format error: %d: %s", err.code, err.message))
			--                                return
			--                            end
			--                            if result == nil then
			--                                return
			--                            end
			--                            vim.lsp.util.apply_text_edits(result, ctx.bufnr, "utf-16")
			--                        end
			--                        local params = {}
			--                        cli:request(method, params, handler, 0)
			--                        --                    vim.lsp.buf.format({ async = false })
			--                    end
			--                end
			--            })

			vim.lsp.config("buf_ls", {
				filetypes = { "proto" },
			})

			vim.lsp.config("graphql", {
				filetypes = { "graphql" },
			})

			vim.lsp.config("ols", {
				init_options = {
					collections = {
						{
							name = vim.fs.basename(vim.fn.getcwd()),
							path = vim.fn.getcwd(),
						},
					},
				},
			})

			vim.lsp.config("zls", {
				filetypes = { "zig" },
			})

			vim.lsp.config("lua_ls", {
				-- and lua settings work only from here
				settings = {
					Lua = {
						hint = {
							enable = false,
						},
						-- nvim-lspconfig enables "N references" lenses, too noisy
						codeLens = {
							enable = false,
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

			vim.lsp.enable({
				"c3_lsp",
				"gopls",
				"buf_ls",
				"graphql",
				"ols",
				"zls",
				"clangd",
				"pyright",
				"lua_ls",
			})
		end,
	},
}
