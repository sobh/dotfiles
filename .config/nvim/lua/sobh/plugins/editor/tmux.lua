-- Package:	Multiple
-- Description: Seamless Navigation between NeoVim, and tmux.
-- URL:		https://github.com/alexghergh/nvim-tmux-navigation
local packages = {
	-- 1
	{
		'alexghergh/nvim-tmux-navigation',
		config = function()
			local tmux = require('nvim-tmux-navigation')
			local maps = require('sobh.mappings').home_row_nav
			local fmt = "<A-%s>"
			local keys = {
				up    = string.format(fmt, maps.up),
				down  = string.format(fmt, maps.down),
				left  = string.format(fmt, maps.left),
				right = string.format(fmt, maps.right),
				last  = string.format(fmt, "\\"),
				next  = string.format(fmt, "Space"),
			}
			tmux.setup({
				disable_when_zoomed = true,
			})
			vim.keymap.set('n', keys.left,  tmux.NvimTmuxNavigateLeft)
			vim.keymap.set('n', keys.down,  tmux.NvimTmuxNavigateDown)
			vim.keymap.set('n', keys.up,    tmux.NvimTmuxNavigateUp)
			vim.keymap.set('n', keys.right, tmux.NvimTmuxNavigateRight)
			vim.keymap.set('n', keys.last,  tmux.NvimTmuxNavigateLastActive)
			vim.keymap.set('n', keys.next,  tmux.NvimTmuxNavigateNext)
		end,
	},
}

return packages[1]
