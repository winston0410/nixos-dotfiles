local function init(use)
	use({
		"ibhagwan/fzf-lua",
		requires = {
			"vijaymarupudi/nvim-fzf",
			"kyazdani42/nvim-web-devicons",
		}, -- optional for icons
		config = function()
			local actions = require("fzf-lua.actions")
			require("fzf-lua").setup({
				fzf_layout = "reverse-list",
				files = {
					cmd = "fd",
					git_icons = true, -- show git icons?
					file_icons = true, -- show file icons?
					color_icons = true, -- colorize file|git icons
				},
				grep = {
					prompt = "",
					actions = {
						["Enter"] = actions.file_edit,
					},
				},
			})

			for _, mode in ipairs({ "n", "v", "i" }) do
				vim.api.nvim_set_keymap(mode, ",m", "<cmd>lua require('fzf-lua').files()<cr>", {
					silent = true,
					noremap = true,
				})
				vim.api.nvim_set_keymap(mode, ",g", "<cmd>lua require('fzf-lua').live_grep()<cr>", {
					silent = true,
					noremap = true,
				})
			end
		end,
	})
end

return {
	init = init,
}
