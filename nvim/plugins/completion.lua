local function init(paq)
	paq({
		"hrsh7th/nvim-compe",
		event = "InsertEnter",
		requires = {
			{ "hrsh7th/vim-vsnip", event = "InsertCharPre" },
			{ "winston0410/friendly-snippets", event = "InsertCharPre" },
		},
		config = function()
			vim.o.completeopt = "menuone,noselect"

			local compe = require("compe")

			compe.setup({
				enabled = true,
				autocomplete = true,
				debug = false,
				min_length = 1,
				preselect = "enable",
				throttle_time = 80,
				source_timeout = 200,
				incomplete_delay = 400,
				max_abbr_width = 100,
				max_kind_width = 100,
				max_menu_width = 100,
				documentation = true,

				source = {
					path = { priority = 80 },
					buffer = { ignored_filetypes = { "sql" }, priority = 90 },
					tags = { ignored_filetypes = { "sql" }, priority = 80 },
					-- spell = { priority = 20 },
					nvim_lsp = { priority = 95 },
					nvim_lua = { priority = 50 },
                    -- Disable in certain file, as lsp provide identical snippets
					vsnip = { priority = 100, ignored_filetypes = { "elixir" } },
					-- rg = { enabled = false, minimum_input = 3, run_when_completions_less_than = 6, priority = 70, ignored_filetypes = { "sql" } },
					-- tmux = { priority = 60, ignored_filetypes = { "sql" } },
				},
			})

			for _, mode in ipairs({ "i", "s" }) do
				vim.api.nvim_set_keymap(
					mode,
					"<CR>",
					"compe#confirm('<CR>')",
					{ expr = true, noremap = true, silent = true }
				)
				vim.api.nvim_set_keymap(
					mode,
					"<Tab>",
					"vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'",
					{ expr = true }
				)

				vim.api.nvim_set_keymap(
					mode,
					"<S-Tab>",
					"vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)':'<S-Tab>'",
					{ expr = true }
				)
			end

			vim.opt.wildignore = {
				"*.o",
				"*.obj,*~",
				"*.git*",
				"*.meteor*",
				"*vim/backups*",
				"*sass-cache*",
				"*mypy_cache*",
				"*__pycache__*",
				"*cache*",
				"*logs*",
				"*node_modules*",
				"**/node_modules/**",
				"*DS_Store*",
				"*.gem",
				"log/**",
				"tmp/**",
			}
		end,
	})
end

return { init = init }
