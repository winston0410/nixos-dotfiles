local function init(paq)
	paq({
		"winston0410/suitcase.nvim",
		keys = {
			{ "n", "e" },
			{ "v", "e" },
			{ "n", "E" },
			{ "v", "E" },
			{ "n", "w" },
			{ "v", "w" },
			{ "n", "W" },
			{ "v", "W" },
		},
		config = function()
			require("suitcase").setup()
		end,
	})
end

return {
	init = init,
}
