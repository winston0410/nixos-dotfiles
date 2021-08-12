local function init(use)
	use({
		"TimUntersberger/neogit",
		requires = "nvim-lua/plenary.nvim",
        keys = { { "n", "<leader>g" }, { "v", "<leader>g" } },
		config = function()
			require("neogit").setup({
				disable_signs = false,
				disable_context_highlighting = false,
				disable_commit_confirmation = true,
				mappings = {
					status = {
						["S"] = "StageAll",
						["U"] = "UnstageAll",
						["c"] = "CommitPopup",
						["p"] = "PushPopup",
						-- ["p"] = "PushPopup",
					},
				},
			})

			local support_modes = { "n", "v" }

			local git_leader_key = "<leader>g"

			for _, mode in ipairs(support_modes) do
				vim.api.nvim_set_keymap(
					mode,
					git_leader_key,
					"<cmd>lua require('neogit').open()<cr>",
					{ silent = true, noremap = true }
				)
			end

            -- Automatically close status buffer after commit?
            -- Use filetype to do the trick
		end,
	})
end

return {
	init = init,
}
