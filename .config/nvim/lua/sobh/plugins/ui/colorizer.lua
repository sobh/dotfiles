-- Package:	nvim-colorizer.lua
-- Description: NvChad colorizer.
-- URL:		https://github.com/NvChad/nvim-colorizer.lua
return {
	'NvChad/nvim-colorizer.lua',
	lazy = true,
	config = function()
		require('colorizer').setup({})
	end,
}

