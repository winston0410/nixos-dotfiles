local function init(paq)
	paq({
		"winston0410/commented.nvim",
		config = function()
			require("commented").setup({
				hooks = {
					before_comment = require("ts_context_commentstring.internal").update_commentstring,
				},
			})
		end,
	})
end

return {
	init = init,
}
