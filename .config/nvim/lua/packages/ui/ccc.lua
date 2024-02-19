-- Package:	ccc.nvim
-- Description: Color picker and highlighter
-- URL:		https://github.com/uga-rosa/ccc.nvim
return {
	'uga-rosa/ccc.nvim',
	config = function()
		local ccc = require('ccc')
		ccc.setup({ })
	end,
}

