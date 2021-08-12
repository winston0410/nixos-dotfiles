local function show_message(id)
	-- print("check id", id, type(id))
	-- local line = vim.api.nvim_win_get_cursor(0)[1]
	-- local list = vim.lsp.diagnostic.get_line_diagnostics(0, line - 1, {}, id)
	-- print('check value', vim.inspect(list))
	vim.lsp.diagnostic.show_line_diagnostics({ 
        focusable = false,
        severity = nil,
        severity_limit = nil,
        close_events = { "BufAdd","TabEnter", "CursorMoved", "BufLeave", "BufUnload"}
    })
	-- vim.lsp.buf.hover({ focusable = false })
end

local function setup(client)
	if client.resolved_capabilities.hover then
		local id = client.id
		vim.api.nvim_exec("autocmd CursorHold * lua require('plugins.smart_hover').show_message(" .. id .. ")", true)
		-- vim.api.nvim_exec("autocmd CursorMoved * lua vim.lsp.buf.clear_references()", true)
	end
end

return {
	show_message = show_message,
	setup = setup,
}
