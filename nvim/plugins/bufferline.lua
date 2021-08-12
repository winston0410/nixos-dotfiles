local function init(use)
	use({
		"akinsho/nvim-bufferline.lua",
		-- "winston0410/nvim-bufferline.lua",
		event = "CursorHold",
		after = "tokyonight.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("bufferline").setup({
				options = {
					numbers = "ordinal",
					diagnostics = "nvim_lsp",
					diagnostics_indicator = function(count, level, errors)
						local icons = ""
						-- https://github.com/akinsho/nvim-bufferline.lua/issues/144
						if level == "error" then
							icons = " "
						end
						return icons
					end,
					enforce_regular_tabs = false,
					show_buffer_close_icons = false,
					show_close_icon = false,
					mappings = false,
					left_mouse_command = "buffer! %d",
					middle_mouse_command = "buffer! %d",
					right_mouse_command = "buffer! %d",
					separator_style = "thin",
					always_show_bufferline = true,
					tab_size = 15,
				},
			})
		end,
	})
	use({
		"winston0410/buf-num-nav.nvim",
		after = "nvim-bufferline.lua",
		requires = {
			{
				"ojroques/nvim-bufdel",
				config = function()
					require("bufdel").setup({
						next = "alternate",
					})
				end,
			},
		},
		config = function()
			require("buf-num-nav").setup({
                leader = "<a-g>",
				commands = {
                    -- TODO: cannot update nvimtree current file with <bar>NvimTreeRefresh
					bufdelete = "BufDel",
				},
			})

			local direction_keys = { "h", "j", "k", "l" }

			for index, key in ipairs(direction_keys) do
				vim.api.nvim_set_keymap("n", "<c-g>" .. key, "<c-w>" .. key, { silent = true, noremap = true })
			end
		end,
	})
end

return {
	init = init,
}
