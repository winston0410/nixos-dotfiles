local function init(use)
	use({
		"winston0410/rg.nvim",
		config = function()
			require("rg").setup({
				on_complete = function()
					vim.cmd("Trouble quickfix")
					-- vim.cmd("QFToggle")
				end,
			})
		end,
	})

	-- use({
		-- "stevearc/qf_helper.nvim",
		-- config = function()
			-- require("qf_helper").setup({
				-- prefer_loclist = true,
				-- sort_lsp_diagnostics = true,
				-- quickfix = {
					-- autoclose = true,
					-- default_bindings = false,
					-- default_options = true,
					-- max_height = 10,
					-- min_height = 1,
					-- track_location = true,
				-- },
				-- loclist = {
					-- autoclose = true,
					-- default_bindings = false,
					-- default_options = true,
					-- max_height = 10,
					-- min_height = 1,
					-- track_location = true,
				-- },
			-- })
		-- end,
	-- })
end

return {
	init = init,
}
