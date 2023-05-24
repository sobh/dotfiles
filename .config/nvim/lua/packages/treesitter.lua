-- Package:	TreeSitter
-- URL:		https://github.com/nvim-treesitter/nvim-treesitter
-- Help:	`:help nvim-treesitter`
--

return {
	'nvim-treesitter/nvim-treesitter',
	dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
	build = function()
		require('nvim-treesitter.install').update({ with_sync = true })
	end,
	config = function()
	end
}
