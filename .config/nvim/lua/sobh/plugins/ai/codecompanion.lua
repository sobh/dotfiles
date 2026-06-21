-- Package:	codecompanion.nvim
-- Description:	AI Coding
-- URL:		https://github.com/olimorris/codecompanion.nvim
--

return {
	"olimorris/codecompanion.nvim",
	version = "^18.0.0",
	opts = {},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("codecompanion").setup({
			interactions = {
				chat = {
					adapter = "kiro",
				},
			},
		})
	end,
}
