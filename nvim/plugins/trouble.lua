local function init(paq)
	paq({
		"folke/trouble.nvim",
		cmd = { "Trouble" },
		config = function()
			require("trouble").setup({
				position = "bottom",
				-- width = 30,
				-- height = 10,
				use_lsp_diagnostic_signs = true,
				indent_lines = false,
				-- auto_open = true,
				-- auto_close = true
			})
		end,
	})
end

return { init = init }
