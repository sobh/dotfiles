-- Package:	snacks.nvim
-- Description:	Utility plugins collection (notifications, etc.)
-- URL:		https://github.com/folke/snacks.nvim

return {
	'folke/snacks.nvim',
	lazy = false,
	opts = {
		notifier = { enabled = true },
		input = { enabled = false },
		words = { enabled = true },
		lazygit = { enabled = true },
	},
	keys = {
		{ ']w', function() require('snacks').words.jump(1) end, desc = 'Next word reference' },
		{ '[w', function() require('snacks').words.jump(-1) end, desc = 'Prev word reference' },
		{ '<leader>gg', function() require('snacks').lazygit() end, desc = 'Lazygit' },
	},
}
