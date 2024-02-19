-- Package:     indent-blankline.nvim
-- Description: Indent guides for NeoVim
-- URL:         https://github.com/lukas-reineke/indent-blankline.nvim
--
return {
	-- Add indentation guides even on blank lines
	{
		'lukas-reineke/indent-blankline.nvim',
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help indent_blankline.txt`
		opts = {
			char = '│',
			show_trailing_blankline_indent = false,
		},
	},

}
