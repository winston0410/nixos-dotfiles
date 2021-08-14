local function init(paq)
	paq({
		"neovim/nvim-lspconfig",
		-- event = "CursorHold",
		config = function()
			local root_dir = function()
				return vim.fn.getcwd()
			end

			local on_attach = function(client)
				require("plugins.smart_hover").setup(client)
				vim.cmd("command! LspNextDiagonistic lua vim.lsp.diagnostic.goto_next{ wrap = true }")
				vim.cmd("command! LspOpenDiagonisticList lua vim.lsp.diagnostic.set_loclist()")
				vim.cmd("command! LspShowTypeSignature lua vim.lsp.buf.type_definition()")
				vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
				vim.cmd("command! LspToDefinition lua vim.lsp.buf.definition()")
				vim.cmd("command! LspToTypeDefinition lua vim.lsp.buf.type_definition()")
				vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
				vim.cmd("command! LspFormat lua vim.lsp.buf.formatting()")
				vim.cmd("command! LspRenameSymbol lua vim.lsp.buf.rename()")
			end

			local lspconfig = require("lspconfig")

			local capabilities = vim.lsp.protocol.make_client_capabilities()

			capabilities.textDocument.completion.completionItem.snippetSupport = true

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { focusable = false })

			local Config = { root_dir = root_dir, capabilities = capabilities, on_attach = on_attach }
			Config.__index = Config

			function Config:new(opts)
				return setmetatable((opts or {}), Config)
			end

			local servers = {
				"solargraph",
				"mint",
				"bicep",
				"ansiblels",
				"vala_ls",
				"jdtls",
				"groovyls",
				"html",
				"cssls",
				"jsonls",
				"leanls",
				"dhall_lsp_server",
				"hls",
				"dartls",
				"terraformls",
				"texlab",
				"ccls",
				"svelte",
				"vuels",
				"sqls",
				"graphql",
				"elmls",
				"ocamlls",
				"puppet",
				"serve_d",
				"gdscript",
				"scry",
				"ember",
				"angularls",
				"bashls",
				"prismals",
				"tsserver",
				-- "denols"
				"dockerls",
				"nimls",
				"metals",
				"julials",
				"purescriptls",
				"yamlls",
				"vimls",
				"rnix",
                "r_language_server",
                "kotlin_language_server"
			}

			for _, server in ipairs(servers) do
                -- TOFIX: passing on_attach function here again, as somehow the on_attach function passed in metatable doesn't work
				lspconfig[server].setup(Config:new({ on_attach = on_attach}))
			end

			lspconfig.elixirls.setup(Config:new({
				cmd = { "elixir-ls" },
			}))
			lspconfig.rust_analyzer.setup(Config:new({
				checkOnSave = {
					allFeatures = true,
					-- overrideCommand = {
					-- "cargo",
					-- "clippy",
					-- "--workspace",
					-- "--message-format=json",
					-- "--all-targets",
					-- "--all-features",
					-- },
				},
			}))
			-- lspconfig.zeta_note.setup({ on_attach = on_attach, root_dir = root_dir })
			lspconfig.cmake.setup(Config:new({
				cmd = { "cmake-language-server" },
				filetypes = { "cmake" },
			}))
			lspconfig.sumneko_lua.setup(Config:new({
				cmd = { "lua-language-server" },
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
							path = vim.split(package.path, ";"),
						},
						completion = { enable = true, callSnippet = "Both" },
						diagnostics = {
							enable = true,
							globals = { "vim", "describe" },
							disable = { "lowercase-global" },
						},
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
								[vim.fn.expand("/usr/share/awesome/lib")] = true,
							},
							-- adjust these two values if your performance is not optimal
							maxPreload = 2000,
							preloadFileSize = 1000,
						},
					},
				},
			}))

			lspconfig.pyright.setup(Config:new({
				cmd = { "pyright-langserver", "--stdio" },
			}))

			local efm_config = Config:new({
				settings = {
					languages = require("plugins.efm"),
				},
			})

			efm_config.filetypes = vim.tbl_keys(efm_config.settings.languages)

			lspconfig.efm.setup(efm_config)

			lspconfig.gopls.setup(Config:new({
				cmd = { "gopls", "serve" },
				settings = {
					gopls = { analyses = { unusedparams = true }, staticcheck = true },
				},
			}))

			-- vim.lsp.handlers["textdocument/publishdiagnostics"] =
			-- vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
			-- virtual_text = true,
			-- signs = true,
			-- update_in_insert = true
			-- })
		end,
	})
end

return { init = init }
