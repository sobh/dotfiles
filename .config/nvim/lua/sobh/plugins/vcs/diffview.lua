-- Package:	diffview.nvim
-- Description:	Diff and file history viewer.
-- URL:		https://github.com/sindrets/diffview.nvim

return {
	'sindrets/diffview.nvim',
	cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
	keys = {
		{ '<leader>gv', '<cmd>DiffviewOpen<cr>',            desc = 'Git Diffview' },
		{ '<leader>gh', '<cmd>DiffviewFileHistory %<cr>',   desc = 'Git File History' },
	},
	opts = function()
		local icons = require('sobh.config.icons')
		return {
			icons = {
				folder_closed = icons.kinds.Folder,
				folder_open = icons.kinds.Folder,
			},
			-- signs = {
			-- 	fold_closed = icons.fold.close,
			-- 	fold_open = icons.fold.open,
			-- 	done = '✓',
			-- },
		}
	end,
}
