-- Color Schemes Packages
local lazy = false
local priority = 1000
return {
	-- Tokyo Night
	{
		'folke/tokyonight.nvim',
		lazy = lazy,
		priority = priority,
		opts = {
			day_brightness = 0.2,     -- From 0.0 to 1.0
			style = 'night',        -- 'storm'|'moon'|'night'|'day'
			-- Styles to be applied to different syntax groups
			styles = {
				comments = { italic=false },
				keywords = { italic=true },
			},
		},
	},
	-- Catppuccin
	{ 'catppuccin/nvim', name = 'catppuccin' },
	-- Kanagawa
	{ 'rebelot/kanagawa.nvim' },
	-- Iceberg
	{
		'cocopon/iceberg.vim',
	},
	-- Rose Pine
	{
		'rose-pine/neovim',
		name = 'rose-pine',
		lazy = lazy,
		priority = priority,
	},
	-- Github
	{
		'projekt0n/github-nvim-theme',
		lazy = lazy,
		priority = priority,
		-- config = function()
		-- 	require('github-theme').setup({
		-- 	})
		-- end,
	},
	-- VS Code
	{
		'Mofiqul/vscode.nvim',
		name = 'theme_vscode',
		lazy = lazy,
		priority = priority,
		config = function()
			local c = require('vscode.colors').get_colors()
			require('vscode').setup({
				-- -- Override colors (see ./lua/vscode/colors.lua)
				-- color_overrides = {
				-- 	vscLineNumber = '#FFFFFF',
				-- },
				-- Override highlight groups (see ./lua/vscode/theme.lua)
				group_overrides = {
					-- this supports the same val table as vim.api.nvim_set_hl
					-- use colors from this colorscheme by requiring vscode.colors!
					Keyword ={ fg=c.vscLightRed ,italic=true },
					Cursor = { fg=c.vscDarkBlue, bg=c.vscLightGreen, bold=true },
				}
			})
			require('vscode').load()
		end,
	},
	-- Atom One Dark
	{
		'navarasu/onedark.nvim',
		lazy = lazy,
		priority = priority,
	},
	-- Bluloco
	{
		'uloco/bluloco.nvim',
		lazy = lazy,
		priority = priority,
		dependencies = { 'rktjmp/lush.nvim' },
		config = function()
			-- your optional config goes here, see below.
		end,
	},
	-- Melange
	{
		'savq/melange-nvim'
	},
}
