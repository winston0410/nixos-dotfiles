local function init(paq)
    -- Cannot use variable outside config function in config
	-- local format_key = "<C-F>"
	paq({
		-- "winston0410/formatter.nvim",
		"mhartington/formatter.nvim",
		opt = true,
		keys = { { "n", "<a-f>" } },
		config = function()
			local function mintfmt()
                -- https://github.com/google/google-java-format
				return {
					exe = "",
					args = { "--", vim.api.nvim_buf_get_name(0) },
					stdin = false,
				}
			end
			local function javafmt()
                -- https://github.com/google/google-java-format
				return {
					exe = "",
					args = { "--", vim.api.nvim_buf_get_name(0) },
					stdin = false,
				}
			end
            local function inifmt()
				return {
					exe = "",
					args = { "--", vim.api.nvim_buf_get_name(0) },
					stdin = false,
				}
			end
			local function nimfmt()
				return {
					exe = "",
					args = { "--", vim.api.nvim_buf_get_name(0) },
					stdin = false,
				}
			end
			local function njkfmt()
				return {
					exe = "",
					args = { "--", vim.api.nvim_buf_get_name(0) },
					stdin = false,
				}
			end
			local function liquidfmt()
				return {
					exe = "",
					args = { "--", vim.api.nvim_buf_get_name(0) },
					stdin = false,
				}
			end
			local function pugfmt()
				-- pugfmt
				return {
					exe = "",
					args = { "--", vim.api.nvim_buf_get_name(0) },
					stdin = false,
				}
			end
			local function mix_format()
				return {
					exe = "mix",
					args = { "format", "--", vim.api.nvim_buf_get_name(0) },
					stdin = false,
				}
			end
			local function dhall_format()
				return {
					exe = "dhall",
					args = { "format", "--", vim.api.nvim_buf_get_name(0) },
					stdin = false,
				}
			end
			local function dhall_lint()
				return {
					exe = "dhall",
					args = { "lint", "--", vim.api.nvim_buf_get_name(0) },
					stdin = false,
				}
			end
			local function elm_format()
				-- Not working
				return {
					exe = "elm-format",
					args = { "--", vim.api.nvim_buf_get_name(0) },
					stdin = false,
				}
			end

			local function styler()
				return {
					exe = "",
					args = { vim.api.nvim_buf_get_name(0) },
					stdin = true,
				}
			end

			local function swift_format()
				return {
					exe = "swift-format",
					args = { vim.api.nvim_buf_get_name(0) },
					stdin = true,
				}
			end

			local function clang_format()
				return {
					exe = "clang-format",
					args = { vim.api.nvim_buf_get_name(0) },
					stdin = true,
				}
			end

			local function goimports()
				return {
					exe = "goimports",
					args = { vim.api.nvim_buf_get_name(0) },
					stdin = true,
				}
			end

			local function fnlfmt()
				return {
					exe = "fnlfmt",
					args = { vim.api.nvim_buf_get_name(0) },
					stdin = true,
				}
			end

			local function prettier()
				return {
					exe = "prettier",
					args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
					stdin = true,
				}
			end

			local function ktlint()
				return {
					exe = "ktlint",
					args = { "--format", vim.api.nvim_buf_get_name(0) },
					stdin = false,
				}
			end

			local function purty()
				return {
					exe = "purty",
					args = { "--", vim.api.nvim_buf_get_name(0) },
					stdin = true,
				}
			end

			local function dockfmt()
				return {
					exe = "dockfmt",
					args = { "--write", "--", vim.api.nvim_buf_get_name(0) },
					stdin = true,
				}
			end

			local function gofmt()
				return {
					exe = "gofmt",
					args = { "--", vim.api.nvim_buf_get_name(0) },
					stdin = true,
				}
			end

			local function go_sqlfmt()
				return {
					exe = "sqlfmt",
					args = { "--", vim.api.nvim_buf_get_name(0) },
					stdin = true,
				}
			end

			local function dartfmt()
				return {
					exe = "dartfmt",
					args = { "--", vim.api.nvim_buf_get_name(0) },
					stdin = true,
				}
			end

			local function rustfmt()
				return {
					exe = "rustfmt",
					args = { "--emit=stdout" },
					stdin = true,
				}
			end

			local function luafmt()
				return {
					exe = "lua-format",
					args = { "--", vim.api.nvim_buf_get_name(0) },
					stdin = true,
				}
			end

			local function nixfmt()
				return {
					exe = "nixfmt",
					args = { "--", vim.api.nvim_buf_get_name(0) },
					stdin = false,
				}
			end

			local function shfmt()
				return {
					exe = "shfmt",
					-- args = {"-w", "--", vim.api.nvim_buf_get_name(0)},
					args = { "-s", "-w", "--", vim.api.nvim_buf_get_name(0) },
					stdin = false,
				}
			end

			local function stylua()
				return {
					exe = "stylua",
					-- args = {"-w", "--", vim.api.nvim_buf_get_name(0)},
					args = { "--", vim.api.nvim_buf_get_name(0) },
					stdin = false,
				}
			end

			local function black()
				return {
					exe = "black",
					-- args = {"-w", "--", vim.api.nvim_buf_get_name(0)},
					args = { "--fast", "--", vim.api.nvim_buf_get_name(0) },
					stdin = false,
				}
			end
			local function hindent()
				return {
					exe = "hindent",
					-- args = {"-w", "--", vim.api.nvim_buf_get_name(0)},
					args = { "--", vim.api.nvim_buf_get_name(0) },
					stdin = false,
				}
			end
			local function sqlfmt()
				return {
					exe = "sqlfmt",
					-- args = {"-w", "--", vim.api.nvim_buf_get_name(0)},
					args = { "--", vim.api.nvim_buf_get_name(0) },
					stdin = false,
				}
			end
			local function latexindent()
				return {
					exe = "latexindent",
					-- args = {"-w", "--", vim.api.nvim_buf_get_name(0)},
					args = { "--", vim.api.nvim_buf_get_name(0) },
					stdin = false,
				}
			end
			local function tffmt()
				return {
					exe = "terraform",
					-- args = {"-w", "--", vim.api.nvim_buf_get_name(0)},
					args = { "fmt", "--", vim.api.nvim_buf_get_name(0) },
					stdin = false,
				}
			end
			require("formatter").setup({
				logging = false,
				filetype = {
					html = { prettier },
					css = { prettier },
					scss = { prettier },
					sass = { prettier },
					less = { prettier },
					javascript = { prettier },
					typescript = { prettier },
					javascriptreact = { prettier },
					typescriptreact = { prettier },
					["javascript.jsx"] = { prettier },
					["typescript.jsx"] = { prettier },
					sh = { shfmt },
					zsh = { shfmt },
					markdown = { prettier },
					-- Use fixjson?
					json = { prettier },
					yaml = { prettier },
					toml = { prettier },
					vue = { prettier },
					svelte = { prettier },
					python = { black },
					dockerfile = { dockfmt },
					-- No formatter for make
					make = {
						-- prettier
					},
					ruby = {},
					lua = { stylua },
					teal = { stylua },
					rust = { rustfmt },
					nix = { nixfmt },
					-- go = { gofmt, goimports, go_sqlfmt },
					go = { gofmt, goimports },
					dart = { dartfmt },
					haskell = { hindent },
					purescript = { purty },
					kotlin = { ktlint },
					java = { javafmt },
					fennel = { fnlfmt },
					cpp = { clang_format },
					c = { clang_format },
					cs = { clang_format },
					swift = { swift_format },
					r = { styler },
					elm = { elm_format },
					elixir = { mix_format },
					sql = {},
					tf = { tffmt },
					plaintex = { latexindent },
					ini = { inifmt },
					dosini = { inifmt },
					dhall = { dhall_lint, dhall_format },
					pug = { pugfmt },
					nunjucks = { njkfmt },
					liquid = { liquidfmt },
					mustache = {},
					wren = {},
					haml = {},
					nim = { nimfmt },
					mint = { mintfmt },
				},
			})

			vim.api.nvim_set_keymap("n", "<a-f>", "<cmd>write<bar>Format<cr>", { silent = true, noremap = true })
		end,
	})
end

return { init = init }
