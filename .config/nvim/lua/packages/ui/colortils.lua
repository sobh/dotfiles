-- Description: Color picker, and other color utilities for NeoVim.
-- URL:		https://github.com/nvim-colortils/colortils.nvim
return {
	'nvim-colortils/colortils.nvim',
	cmd = 'Colortils',
	config = function()
		require('colortils').setup()
	end,
}

