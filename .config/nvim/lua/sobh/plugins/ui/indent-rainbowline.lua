-- Package:     indent-rainbowline.nvim
-- Description: Rainbow indent guides (wraps indent-blankline)
-- URL:         https://github.com/TheGLander/indent-rainbowline.nvim

return {
	'TheGLander/indent-rainbowline.nvim',
	dependencies = { 'lukas-reineke/indent-blankline.nvim' },
	main = 'ibl',
	event = 'BufReadPost',
	opts = function()
		return require('indent-rainbowline').make_opts({}, {
			color_transparency = 0.15,
			colors = { 0xE5C07B, 0x61AFEF, 0xC678DD, 0xD19A66, 0x56B6C2 },
		})
	end,
}
