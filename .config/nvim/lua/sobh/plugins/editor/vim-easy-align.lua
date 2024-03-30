-- Package:	vim-easy-align
-- Description: Text Alignment.
-- URL:		https://github.com/junegunn/vim-easy-align
return {
	'junegunn/vim-easy-align',
	config = function()
		-- Load Key Mappings
		require('sobh.mappings').load('vim-easy-align')
	end,
}

