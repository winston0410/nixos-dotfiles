local function init(paq)
  paq{'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/plenary.nvim'}, { 'nvim-lua/popup.nvim' }}, config = function()

  local actions = require('telescope.actions')
  require('telescope').setup{
	defaults = {
	  mappings = {
		n = {
		  ['<c-x>'] = false,
		  ['<c-s>'] = actions.select_horizontal,
		  ['<c-q>'] = actions.send_to_qflist,
		},
		i = {
		  ['<c-x>'] = false,
		  ['<c-s>'] = actions.select_horizontal,
		  ['<c-q>'] = actions.send_to_qflist,
		},
	  },
	  color_devicons = true,
	  prompt_position = 'bottom',
	  prompt_prefix = '🔍 ',
	  sorting_strategy = 'ascending',
	  layout_strategy = 'horizontal',
	  preview_cutoff = 1,
	  file_ignore_patterns = { 'node_modules/.*', '.git/.*', '_site/.*' },
	  layout_defaults = {
		horizontal = {
		  -- mirror = true,
		},
		vertical = {
		  mirror = true,
		}
	  },
	},
	extensions = {
	  fzf = {
		override_generic_sorter = false,
		override_file_sorter = true,
		case_mode = "smart_case"
	  }
	}
  }

  end}


end

return {
  init = init
}
