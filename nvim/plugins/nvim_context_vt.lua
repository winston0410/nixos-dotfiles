local ts_utils = require 'nvim-treesitter.ts_utils';

local function init(paq)
	-- paq{'haringsrob/nvim_context_vt'}
	paq{'winston0410/nvim_context_vt'}
	require('nvim_context_vt').setup({
		custom_text_handler = function (node)
			return ts_utils.get_node_text(node)[1]
		end
	})
end

return {
	init = init
}

