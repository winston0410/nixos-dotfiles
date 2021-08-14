package.path = package.path .. ";" .. vim.fn.getenv("HOME") .. "/.config/nvim/?.lua"

local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({ "git", "clone", "https://github.com/winston0410/packer.nvim.git", install_path })
	vim.api.nvim_command("packadd packer.nvim")
	vim.cmd("PackerSync")
end

--Sensible default mapping
-- Use space as leader key
vim.g.mapleader = " "
local modes = { "n", "v" }
local mappings = {
	{ "<leader>y", '"+y' },
	{ "<leader>p", '"+p' },
	{ "<leader>P", '"+P' },
	{ "<leader>d", '"+d' },
	{ "Y", "y$" },
	{ "S", "<NOP>" },
	{ "s", "<NOP>" },
	{ "<A-v>", "<c-v>" },
}

vim.api.nvim_set_keymap("i", "<A-r>", "<C-r>", { silent = true, noremap = true})

vim.api.nvim_set_keymap("n", "gs", ":%s/", { silent = true, noremap = true })
vim.api.nvim_set_keymap("v", "gs", ":s/", { silent = true, noremap = true })
-- Important: Paste in visual mode without copying
vim.api.nvim_set_keymap("v", "p", "pgvy", { silent = true, noremap = true })
vim.api.nvim_set_keymap("v", "P", "Pgvy", { silent = true, noremap = true })
-- Important: Revert back to previous cursor position
vim.api.nvim_set_keymap("i", "<esc>", "<esc>`^", { silent = true, noremap = true })

for _, mapping in ipairs(mappings) do
	for _, mode in ipairs(modes) do
		vim.api.nvim_set_keymap(mode, mapping[1], mapping[2], { silent = true, noremap = true })
	end
end

local all_modes = { "i", "n", "v", "c", "t", "s" }

for _, mode in pairs(all_modes) do
	vim.api.nvim_set_keymap(mode, "<A-[>", "<esc>", { silent = true, noremap = true })
	vim.api.nvim_set_keymap(mode, "<A-p>", "<Up>", { silent = true, noremap = true })
	vim.api.nvim_set_keymap(mode, "<A-n>", "<Down>", { silent = true, noremap = true })
end


--vim.cmd([[ source $HOME/.config/nvim/values.vim ]])
vim.cmd("syntax enable")
--vim.cmd "filetype plugin on"
vim.cmd("filetype plugin indent on")
vim.cmd("set shortmess+=c")

--Quit default plugin early
vim.g.loaded_zipPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_gzip = 1
vim.g.loaded_man = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_tutor_mode_plugin = 1

local global_options = {
	{ "encoding", "UTF-8" },
	{ "fileencoding", "UTF-8" },
	{ "termguicolors", true },
	{ "mouse", "nvic" },
	{ "timeoutlen", 400 },
	{ "ttimeoutlen", 0 },
	{ "updatetime", 300 },
	{ "showmode", false },
	{ "backup", false },
	{ "writebackup", false },
	{ "cmdheight", 1 },
	{ "showmatch", true },
	{ "splitbelow", true },
	{ "splitright", true },
	{ "lazyredraw", true },
	{ "ignorecase", true },
	{ "smartcase", true },
	{ "magic", true },
	{ "grepprg", "rg --vimgrep --no-heading --smart-case" },
	{ "grepformat", "%f:%l:%c:%m" },
	{ "wildmenu", true },
	{ "wildmode", "longest:full,full" },
}

for _, option in ipairs(global_options) do
	vim.api.nvim_set_option(option[1], option[2])
end

local window_options = {
	{ "wrap", true },
	{ "linebreak", true },
	{ "number", true },
	{ "relativenumber", true },
	{ "signcolumn", "yes" },
	{ "scrolloff", 8 },
	-- Ensure tilde signs are not show at the end of buffer
	{ "fillchars", "eob: " },
}

for _, option in ipairs(window_options) do
	vim.o[option[1]] = option[2]
	vim.wo[option[1]] = option[2]
end

-- Doesn't apply to newly included buffer?
local buffer_options = {
	{ "expandtab", true },
	{ "autoindent", true },
	{ "smartindent", false },
	{ "grepprg", "rg --vimgrep --no-heading --smart-case" },
	{ "undofile", true },
	{ "shiftwidth", 4 },
	{ "tabstop", 4 },
}

for _, option in ipairs(buffer_options) do
	vim.o[option[1]] = option[2]
	vim.bo[option[1]] = option[2]
end

require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	require("plugins.trouble").init(use)
	require("plugins.treesitter").init(use)
	require("plugins.quickfix").init(use)
	require("plugins.magit").init(use)
	require("plugins.lspconfig").init(use)
	require("plugins.edge").init(use)
	require("plugins.hop").init(use)
	require("plugins.gitsigns").init(use)
	require("plugins.indent-blankline").init(use)
	-- require("plugins.telescope").init(use)
	require("plugins.galaxyline").init(use)
	require("plugins.formatter").init(use)
	--require("plugins.colorizer").init(use)
	require("plugins.completion").init(use)
	-- require('plugins.numb').init(use)
	require("plugins.range-highlight").init(use)
	-- require("plugins.lightspeed").init(use)
	require("plugins.better-O").init(use)
	-- require('plugins.reverse-J').init(use)
	require("plugins.commented").init(use)
	require("plugins.bufferline").init(use)
	require("plugins.hardmode").init(use)
	require("plugins.nvim-tree").init(use)
	require("plugins.smart-number").init(use)
	-- require("plugins.suitcase").init(use)
	-- require("plugins.which-key").init(use)
	-- require('plugins.nvim_context_vt').init(use)
end)

vim.api.nvim_exec(
	[[ 
	augroup yank_highlight
	autocmd!
	au TextYankPost * silent! lua vim.highlight.on_yank { higroup='Visual', timeout=500 }
	augroup END
	]],
	true
)

-- vim.api.nvim_exec(
	-- [[
-- augroup EnvFiletype
-- autocmd!
-- autocmd BufNewFile,BufRead *.env set filetype=dotenv.sh
-- autocmd BufNewFile,BufRead *.tmux set filetype=tmux.sh
-- autocmd BufNewFile,BufRead *.lock set filetype=sh
-- autocmd BufNewFile,BufRead *.config set filetype=config
-- autocmd BufNewFile,BufRead .tmux.conf set filetype=tmux.sh
-- autocmd BufNewFile,BufRead package.json set filetype=packageJson.json
-- augroup END
-- ]],
	-- true
-- )

-- vim.cmd([[
-- " Change search highlight
-- highlight! link Search Visual
-- " Change incsearch highlight
-- highlight! link IncSearch Visual
-- ]])

-- "Override theme highlight
-- highlight! link VirtualTextHint Blue
-- highlight! link HintText Blue
-- "gitsigns
-- highlight! link GitSignsAdd Green
-- highlight! link GitSignsChange Yellow
-- highlight! link GitSignsDelete Red
-- "LspInfomation
-- highlight! link LspDiagnosticsSignHint BlueSign
-- " Gitsigns
-- highlight! link GitSignsCurrentLineBlame TSComment
-- " relativenumber current line highlight
-- " Use cleared to make it white
-- highlight! link CursorLineNr cleared
