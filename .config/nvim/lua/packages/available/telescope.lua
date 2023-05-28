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
		-- See `:help telescope` and `:help telescope.setup()`

		-- require('telescope').setup {
		-- 	defaults = {
		-- 		mappings = {
		-- 			i = {
		-- 				['<C-u>'] = false,
		-- 				['<C-d>'] = false,
		-- 			},
		-- 		},
		-- 	},
		-- }

		-- Load Key Mappings
		local wk = require('which-key')
		local mappings = require('mappings').telescope
		wk.register(mappings)

		-- Enable telescope fzf native, if installed
		pcall(require('telescope').load_extension, 'fzf')
	end,
}
