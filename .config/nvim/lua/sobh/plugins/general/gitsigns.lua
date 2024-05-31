-- Package:     gitsigns.nvim
-- Description: Git Integration
-- URL:         https://github.com/lewis6991/gitsigns.nvim
--
local icons = require('sobh.config.icons')
return {
	'lewis6991/gitsigns.nvim',
	opts = {
		signs = {
			add       = { text = icons.git.gutter.added },
			change    = { text = icons.git.gutter.modified },
			delete    = { text = icons.git.gutter.removed },
			topdelete = { text = icons.git.gutter.removed },
			untracked = { text = icons.git.gutter.untracked },
		},
		signcolumn = true,     -- Toggle with `:Gitsigns toggle_signs`
		numhl      = true,     -- Toggle with `:Gitsigns toggle_numhl`
		linehl     = false,    -- Toggle with `:Gitsigns toggle_linehl`
		word_diff  = false,    -- Toggle with `:Gitsigns toggle_word_diff`
		on_attach = function ()
			require("sobh.mappings").load("editor.gitsigns")
		end
	},
}
