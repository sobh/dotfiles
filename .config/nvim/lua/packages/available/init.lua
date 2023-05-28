-- Simple Packages that don't require any configuration
--

return {
	-- -- Git related plugins
	-- 'tpope/vim-fugitive',
	-- 'tpope/vim-rhubarb',
	--
	-- -- Detect tabstop and shiftwidth automatically
	-- 'tpope/vim-sleuth',

	-- "gc" to comment visual regions/lines
	{ 'numToStr/Comment.nvim', opts = {} },

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
