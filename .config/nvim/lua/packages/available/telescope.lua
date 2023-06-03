-- Package: https://github.com/nvim-telescope/telescope.nvimrequ
return {
	-- Fuzzy Finder (files, lsp, etc)
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	dependencies = {
		-- Required
		'nvim-lua/plenary.nvim',
		-- Optional
		'nvim-tree/nvim-web-devicons',
		-- For Key Mappings
		'folke/which-key.nvim',
	},
	config = function()
		-- Load Key Mappings
		require('mappings').load('telescope')

		-- Enable telescope fzf native, if installed
		pcall(require('telescope').load_extension, 'fzf')
	end,
}
