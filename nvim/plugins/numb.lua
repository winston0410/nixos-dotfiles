local function init(paq)
	paq({ "nacro90/numb.nvim" })
	require("numb").setup({})
end

return {
	init = init,
}
