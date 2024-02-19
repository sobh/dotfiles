-- Package:	vim-stabs
-- Description: Tabs for Indentation, Spaces for Alignment
-- URL:		https://github.com/sobh/vim-stabs
return {
	'sobh/vim-stabs',
	config = function()
		vim.g.stabs_align_width = 4	-- Set Alignment Step Width
	end,
}

