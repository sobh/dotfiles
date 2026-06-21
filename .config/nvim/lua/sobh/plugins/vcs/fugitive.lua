-- Package:	vim-fugitive
-- Description:	Git integration.
-- URL:		https://github.com/tpope/vim-fugitive

return {
	'tpope/vim-fugitive',
	cmd = { 'Git', 'G' },
	keys = {
		{ '<leader>gb', '<cmd>Git blame<cr>', desc = 'Git Blame (drill with ~)' },
	},
}
