-- Package: https://github.com/nvim-telescope/telescope.nvimrequ
return {
	-- Fuzzy Finder (files, lsp, etc)
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	dependencies = { 
		-- Required
		'nvim-lua/plenary.nvim',
		-- Optional
		'nvim-tree/nvim-web-devicons'
	},
	config = function()
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
		vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
		-- ThePrimeagen
		vim.keymap.set('n', '<C-p>', builtin.git_files, {})
	end,
}
