-- Package:	nvim-tree.lua
-- Description:	A file explorer tree for neovim written in lua.
-- URL:		https://github.com/nvim-tree/nvim-tree.lua

return {
	'nvim-tree/nvim-tree.lua',
	version = '*',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	keys = {
		{ '<leader>et', '<cmd>NvimTreeToggle<cr>', desc = 'Explorer toggle' },
		{ '<leader>ef', '<cmd>NvimTreeFocus<cr>',  desc = 'Explorer focus' },
	},
	opts = {
		hijack_cursor = false,
		sync_root_with_cwd = true,
	},
}
