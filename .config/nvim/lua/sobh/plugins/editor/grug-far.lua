-- Package:	grug-far.nvim
-- Description:	Find and replace across files.
-- URL:		https://github.com/MagicDuck/grug-far.nvim

return {
	'MagicDuck/grug-far.nvim',
	cmd = 'GrugFar',
	keys = {
		{ '<leader>sr', '<cmd>GrugFar<cr>', desc = 'Search and Replace (workspace)' },
		{ '<leader>sb', function() require('grug-far').open({ prefills = { paths = vim.fn.expand('%') } }) end, desc = 'Search and Replace (buffer)' },
	},
	opts = {},
}
