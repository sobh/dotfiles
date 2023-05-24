-- Package: https://github.com/nvim-tree/nvim-web-devicons
return {
	'ibhagwan/fzf-lua',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		local fzf_lua = require('fzf-lua')
		vim.keymap.set('n', '<leader>fc', fzf_lua.colorschemes , { desc = 'Preview Color Schemes' })
	end,
}
