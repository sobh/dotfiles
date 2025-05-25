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
				php = { "php" },
				python = { "isort", "black" },
				xml = { "xml" },
			},
			formatters = {
				php = {
					command = "php-cs-fixer",
					args = {
						"fix",
						"--config=.php-cs-fixer.php",
						"$FILENAME",
					},
					stdin = false,
					cwd = require("conform.util").root_file({ ".php-cs-fixer.php" }),
					env = { PHP_CS_FIXER_IGNORE_ENV = 1 },
				},
				xml = {
					command = "xmllint",
					args = { "--format", "-" },
					env = { XMLLINT_INDENT = "\t" },
				},
			},
		})
		-- Load Key Mappings
		require("sobh.mappings").load("code.formatter")
	end,
}
