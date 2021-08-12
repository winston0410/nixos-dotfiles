local function init(paq)
	paq({
		"folke/tokyonight.nvim",
		event = "BufEnter",
		-- after = "nvim-tree.lua",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			vim.g.tokyonight_style = "night"
			vim.cmd("colorscheme tokyonight")

			local highlight_list = {
				-- { "Search", "Visual" },
				-- { "IncSearch", "Visual" },
				{ "CursorLineNr", "cleared" },
				-- highlight! link CursorLineNr cleared
			}

			for _, highlight in ipairs(highlight_list) do
				vim.cmd("highlight! link" .. " " .. highlight[1] .. " " .. highlight[2])
			end
		end,
	})
end

return { init = init }
