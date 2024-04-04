local lazy = false
local priority = 1000
return {
	-- Cairo Noon
	{
		"sobh/caironoon.nvim",
		url = "git@github.com:sobh/caironoon.nvim.git",
		lazy = lazy,
		priority = priority,
	},
	-- TokyoNight
	{
		"folke/tokyonight.nvim",
		lazy = lazy,
		priority = priority,
		opts = {
			style = "moon",
			styles = {
				comments = { italic = false },
				keywords = { italic = true },
			},
		},
	},
}
