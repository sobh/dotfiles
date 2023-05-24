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
		vim.keymap.set('n', '<leader>f', '', { desc = 'Fuzzy Finder' })
		vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
		vim.keymap.set('n', '<leader>fg', builtin.git_files,  { desc = 'Find Git Files'})
		vim.keymap.set('n', '<leader>fs', builtin.live_grep,  { desc = 'Search in Files' })
		vim.keymap.set('n', '<leader>fb', builtin.buffers,    { desc = 'Find Open Buffer' })
		vim.keymap.set('n', '<leader>fh', builtin.help_tags,  { desc = 'Search NeoVim Help' })
	end,
}
