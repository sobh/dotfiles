-- Color Schemes Packages
return {
	-- Tokyo Night
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	}
	-- Rose Pine
	{
		'rose-pine/neovim',
		lazy = true,
		name = 'rose-pine'
	},
	{
		-- Theme inspired by Atom
		'navarasu/onedark.nvim',
		priority = 1000,
	},
}
