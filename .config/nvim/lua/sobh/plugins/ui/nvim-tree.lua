-- Package:	nvim-tree.lua
-- Description:	A file explorer tree for neovim written in lua.
--		command.
-- URL:		https://github.com/nvim-tree/nvim-tree.lua
--
return {
	'nvim-tree/nvim-tree.lua',
	version = '*',
	dependencies = {
		'nvim-tree/nvim-web-devicons',
	},
	config = function()
		-- :help nvim-tree-setup
		require('nvim-tree').setup {
			hijack_cursor = false,
			sync_root_with_cwd = true,
		}
		-- Load Mapping
		require('mappings').load('nvim-tree')
	end,
}
