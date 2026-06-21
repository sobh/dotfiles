-- Package:	fzf-lua
-- Description:	Fuzzy finder (fzf-based, faster than Telescope)
-- URL:		https://github.com/ibhagwan/fzf-lua

return {
	'ibhagwan/fzf-lua',
	cmd = 'FzfLua',
	config = function()
		require('fzf-lua').setup({
			winopts = {
				preview = { layout = 'vertical' },
			},
		})
		require('sobh.mappings').load('fzf-lua')
	end,
}
