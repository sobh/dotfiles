-- Package:	snacks.nvim (explorer)
-- Description:	File explorer from snacks.nvim.
-- URL:		https://github.com/folke/snacks.nvim

return {
	'folke/snacks.nvim',
	keys = {
		{ '<leader>et', function() require('snacks').explorer() end, desc = 'Explorer toggle' },
		{ '<leader>ef', function() require('snacks').explorer.focus() end, desc = 'Explorer focus' },
	},
	opts = {
		explorer = { enabled = true },
		notifier = { enabled = true },
	},
}
