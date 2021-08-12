local function init(paq)
	paq({
		"lukas-reineke/indent-blankline.nvim",
        after = "tokyonight.nvim",
		config = function()
			vim.g.indent_blankline_use_treesitter = true
			vim.g.indent_blankline_char = "│"
			vim.g.indent_blankline_space_char = "."
		end,
	})
end

return {
	init = init,
}
