local function init(use)
	use({
		"kyazdani42/nvim-tree.lua",
        -- event = "CursorHold",
		requires = { {
			"kyazdani42/nvim-web-devicons",
			opt = true,
		} },
		config = function()
			vim.g.nvim_tree_auto_open = 1
			vim.g.nvim_tree_gitignore = 0
			vim.g.nvim_tree_follow = 1
			vim.g.nvim_tree_hijack_cursor = 1
			vim.g.nvim_tree_disable_window_picker = 1
			vim.g.nvim_tree_hide_dotfiles = 0
			vim.g.nvim_tree_git_hl = 1
			vim.g.nvim_tree_highlight_opened_files = 3
			vim.g.nvim_tree_add_trailing = 0
			vim.g.nvim_tree_lsp_diagnostics = 1
			vim.g.nvim_tree_ignore = {}
			vim.g.nvim_tree_update_cwd = 0
			vim.g.nvim_tree_window_picker_exclude = {
				filetype = {
					"packer",
					"NeogitStatus",
				},
			}

			-- How to highlight .gitignore seperately?
			-- vim.g.nvim_tree_special_files = {
			-- [".gitignore"] = true,
			-- Makefile = true,
			-- ["README.md"] = true,
			-- ["readme.md"] = true,
			-- }

			vim.g.nvim_tree_show_icons = {
				git = 0,
				folders = 1,
				files = 1,
			}

			vim.g.nvim_tree_icons = {
				git = {
					unstaged = "",
					staged = "",
					unmerged = "",
					renamed = "",
					untracked = "",
					deleted = "",
				},
				lsp = {
					hint = " ",
					info = " ",
					warning = " ",
					error = " ",
				},
			}

			for _, mode in ipairs({ "n", "v", "i" }) do
				vim.api.nvim_set_keymap(mode, "<a-g>m", "<cmd>NvimTreeToggle<cr>", {
					silent = true,
					noremap = true,
				})
			end

			-- TODO: Add highlight for

			-- local hl_sets = {
				-- { "NvimTreeGitDirty", "Red" },
				-- -- { "NvimTreeFileStaged", "Red" },
				-- -- { "NvimTreeFileMerge", "Red" },
				-- -- { "NvimTreeFileRenamed", "Red" },
				-- -- { "NvimTreeFileNew", "Red" },
				-- -- { "NvimTreeFileDeleted", "Red" },
				-- { "NvimTreeGitNew", "Red" },
				-- { "NvimTreeGitDeleted", "Red" },
			-- }

			-- for _, hl in ipairs(hl_sets) do
				-- vim.cmd("highlight! link" .. " " .. hl[1] .. " " .. hl[2])
				-- -- vim.highlight.link(hl[1], hl[2], true)
			-- end
		end,
	})
end

return {
	init = init,
}
