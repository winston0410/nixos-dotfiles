local function init(use)
	vim.api.nvim_exec(
		[[
  augroup SmartNumberGroup
  autocmd!
  autocmd CmdlineEnter : lua require("plugins.smart-number").use_absolute_number()
  autocmd CmdlineLeave : lua require("plugins.smart-number").use_relative_number()
  augroup END]],
		true
	)
end

local exclude_ft = {
    NvimTree = true,
    packer = true,
    NeogitStatus = true,
    gitcommit = true
}

local function use_relative_number()
    if exclude_ft[vim.o.filetype] then
        return
    end
	vim.o.relativenumber = true
	vim.wo.relativenumber = true

	vim.cmd("redraw")
end

local function use_absolute_number()
    if exclude_ft[vim.o.filetype] then
        return
    end
	vim.o.relativenumber = false
	vim.wo.relativenumber = false
end

return {
	init = init,
	use_relative_number = use_relative_number,
	use_absolute_number = use_absolute_number,
}
