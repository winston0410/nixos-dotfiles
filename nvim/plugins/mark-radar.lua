local function init(paq)
	paq({ "winston0410/mark-radar.nvim", config = function ()

	require("mark-radar").setup({
        background_highlight = true
	})
    end})
end

return {
	init = init,
}
