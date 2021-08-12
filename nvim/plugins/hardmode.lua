local function init(use)
	local arrow_keys = { "<Up>", "<Down>", "<Left>", "<Right>" }
	-- local disable_modes = { "n", "v", "i", "o", "c", "t" }
	local disable_modes = { "n", "v", "i", "o", "t" }

	for _, key in ipairs(arrow_keys) do
		for _, mode in ipairs(disable_modes) do
			vim.api.nvim_set_keymap(mode, key, "<Nop>", { silent = true, noremap = true })
		end
	end
end

return {
	init = init,
}
