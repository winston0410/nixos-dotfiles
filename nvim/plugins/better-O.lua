local function init(paq)
	paq({ "winston0410/smart-cursor.nvim" })
	paq({
		"winston0410/better-O.nvim",
		keys = { { "n", "o" }, { "n", "O" } },
		config = function()
			require("better-O").setup({ enter_insert_mode = false, set_keybinding = true })

			vim.api.nvim_set_keymap(
				"n",
				"O",
				'<cmd>lua require("better-O").insert_new_line()<CR><cmd>lua require("smart-cursor").indent_cursor()<cr>',
				{ silent = true, noremap = true }
			)

			-- vim.api.nvim_set_keymap(
				-- "n",
				-- "o",
				-- "o<esc><cmd>lua require('smart-cursor').indent_cursor()<cr>",
				-- { silent = true, noremap = true }
			-- )
            
			vim.api.nvim_set_keymap(
				"n",
				"o",
				"o<esc><cmd>lua require('smart-cursor').indent_cursor()<cr>",
				{ silent = true, noremap = true }
			)
		end,
	})
end

return {
	init = init,
}
