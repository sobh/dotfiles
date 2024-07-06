-- Package:	conform.nvim
-- Description:	Code formatter.
-- URL:		https://github.com/stevearc/conform.nvim
--

return {
	"stevearc/conform.nvim",

	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
			},
		})
		-- Load Key Mappings
		require("sobh.mappings").load("code.formatter")
	end,
}
