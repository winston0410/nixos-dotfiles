local function init(use)
	use({
		"phaazon/hop.nvim",
		-- "winston0410/hop.nvim",
		-- keys = { { "n", "<Leader><Leader>" }, { "v", "<Leader><Leader>" } },
		keys = { { "n", "<leader>f" }, { "v", "<leader>f" },{ "n", "<leader>F" }, { "v", "<leader>F" } },
		config = function()
			require("hop").setup({})

			local supported_modes = { "n", "v", "o" }

			for _, mode in ipairs(supported_modes) do
				-- vim.api.nvim_set_keymap(
					-- mode,
					-- "<Leader><Leader>",
					-- "<cmd>HopChar1<cr>",
					-- { noremap = true, silent = true }
				-- )
				vim.api.nvim_set_keymap(
					mode,
					"<leader>f",
					"<cmd>HopChar1<cr>",
					{ noremap = true, silent = true }
				)
				vim.api.nvim_set_keymap(
					mode,
					"<leader>F",
					"<cmd>HopChar1<cr>",
					{ noremap = true, silent = true }
				)
				-- vim.api.nvim_set_keymap(mode, "<Leader>w", "<cmd>HopWord<cr>", { noremap = true, silent = true })
				-- vim.api.nvim_set_keymap(mode, "t", "<cmd>HopChar1AC<cr>", { noremap = true, silent = true })
				-- vim.api.nvim_set_keymap(mode, "T", "<cmd>HopChar1BC<cr>", { noremap = true, silent = true })
			end
		end,
	})
end

return {
	init = init,
}
