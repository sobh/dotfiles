-- Package:	nvim-highlight-colors
-- Description: Highlight colors based on their HEX/rgb/hsl value.
-- URL:		https://github.com/brenoprata10/nvim-highlight-colors
return {
	'brenoprata10/nvim-highlight-colors',
	config = function()
		local colors = require('nvim-highlight-colors')
		colors.setup({
			-- custom_colors = {
			-- 	{label='Red',    color= '#F00'},
			-- 	{label='Blue',    color= '#00F'},
			-- 	{label='Green',    color= '#008000'},
			-- 	{label='Yellow', color= '#FF0'},
			-- }
		})
		colors.turnOn()
	end,
}
