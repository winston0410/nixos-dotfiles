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

			local Config = { root_dir = root_dir, capabilities = capabilities, on_attach = on_attach }
			Config.__index = Config

			function Config:new(opts)
				return setmetatable((opts or {}), Config)
			end

			lspconfig.solargraph.setup(Config:new())
			lspconfig.vala_ls.setup(Config:new())
			lspconfig.jdtls.setup(Config:new())
			lspconfig.groovyls.setup(Config:new())
			lspconfig.html.setup(Config:new())
			lspconfig.cssls.setup(Config:new())
			lspconfig.jsonls.setup(Config:new())
			lspconfig.elixirls.setup(Config:new({
				cmd = { "elixir-ls" },
			}))
			lspconfig.leanls.setup(Config:new())
			lspconfig.dhall_lsp_server.setup(Config:new())
			lspconfig.hls.setup(Config:new())
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
			lspconfig.dartls.setup(Config:new())
			lspconfig.terraformls.setup(Config:new())
			lspconfig.texlab.setup(Config:new())
			lspconfig.ccls.setup(Config:new())
			lspconfig.svelte.setup(Config:new())
			lspconfig.vuels.setup(Config:new())
			lspconfig.sqls.setup(Config:new())
			lspconfig.graphql.setup(Config:new())
			lspconfig.elmls.setup(Config:new())
			lspconfig.ocamlls.setup(Config:new())
			lspconfig.puppet.setup(Config:new())
			lspconfig.serve_d.setup(Config:new())
			lspconfig.gdscript.setup(Config:new())
			lspconfig.scry.setup(Config:new())
			lspconfig.ember.setup(Config:new())
			lspconfig.angularls.setup(Config:new())
			lspconfig.bashls.setup(Config:new())
			lspconfig.prismals.setup(Config:new())
			-- lspconfig.zeta_note.setup({ on_attach = on_attach, root_dir = root_dir })
			lspconfig.r_language_server.setup(Config:new())
			lspconfig.kotlin_language_server.setup(Config:new())
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
			lspconfig.tsserver.setup(Config:new())
			-- lspconfig.denols.setup(standard_config)
			lspconfig.dockerls.setup(Config:new())
			lspconfig.nimls.setup(Config:new())
			lspconfig.metals.setup(Config:new())
			lspconfig.julials.setup(Config:new())
			lspconfig.purescriptls.setup(Config:new())
			lspconfig.yamlls.setup(Config:new())
			lspconfig.vimls.setup(Config:new())
			lspconfig.rnix.setup(Config:new())
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

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { focusable = false })

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
