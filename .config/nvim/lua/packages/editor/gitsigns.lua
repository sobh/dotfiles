-- Package:     gitsigns.nvim
-- Description: Git Integration
-- URL:         https://github.com/lewis6991/gitsigns.nvim
--
return {
	'lewis6991/gitsigns.nvim',
	opts = {
		signs = {
			add = { text = require('config.icons').git.gutter.added },
			change = { text = require('config.icons').git.gutter.modified },
			delete = { text = require('config.icons').git.gutter.removed },
			topdelete = { text = require('config.icons').git.gutter.removed },
			untracked = { text = require('config.icons').git.gutter.untracked },
		},
		signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
		numhl      = true, -- Toggle with `:Gitsigns toggle_numhl`
		linehl     = true, -- Toggle with `:Gitsigns toggle_linehl`
		word_diff  = true, -- Toggle with `:Gitsigns toggle_word_diff`
	},
}
