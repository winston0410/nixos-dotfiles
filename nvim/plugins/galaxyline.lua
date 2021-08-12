local function init(paq)
	paq({
		-- "hoob3rt/lualine.nvim",
		"shadmansaleh/lualine.nvim",
		after = "tokyonight.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			-- local color
			local colors = require("tokyonight.colors").setup()
			-- print('check colors', vim.inspect(colors))
			require("lualine").setup({
				options = {
					theme = "tokyonight",
					component_separators = "",
					section_separators = "",
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
					lualine_c = {},
					lualine_x = {},
					lualine_y = {
						{
							"filename",
							file_status = true,
							path = 2,
							color = { fg = colors.fg, bg = colors.bg_statusline },
						},
					},
					lualine_z = {
						{
							"diagnostics",
							sources = { "nvim_lsp" },
							symbols = { error = " ", warn = " ", info = " " },
							-- color_error = colors.red,
							-- color_warn = colors.yellow,
							-- color_info = colors.cyan,
							color = { bg = colors.bg_statusline },
						},
						{
							-- Check if active LSP exist
							function()
								local msg = ""
								local clients = vim.lsp.get_active_clients()
								if #clients < 1 then
									msg = "年"
									return msg
								end
								return ""
							end,
							color = { fg = colors.fg, bg = colors.bg_statusline },
						},
					},
				},
			})
		end,
	})
end

return {
	init = init,
}
