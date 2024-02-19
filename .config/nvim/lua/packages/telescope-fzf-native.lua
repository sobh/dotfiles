-- Package: https://github.com/nvim-telescope/telescope-fzf-native.nvim
-- NOTE: If you are having trouble with this installation,
--       refer to the README for telescope-fzf-native for more instructions.
return {
	'nvim-telescope/telescope-fzf-native.nvim',
	build = 'make',
	cond = function()
		return vim.fn.executable 'make' == 1
	end,
}
