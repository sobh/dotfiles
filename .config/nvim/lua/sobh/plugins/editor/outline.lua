-- Package:	outline.nvim
-- Description: Code Outline Sidebar
-- URL:		https://github.com/hedyhli/outline.nvim
return {
	'hedyhli/outline.nvim',
	config = function()
		-- Load Key Mappings
		require('sobh.mappings').load('editor.outline')
		-- Setup the plugin
		require("outline").setup({})
	end,
}

