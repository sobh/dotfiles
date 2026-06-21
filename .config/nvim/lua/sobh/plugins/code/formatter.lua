-- Package:	conform.nvim
-- Description:	Code formatter.
-- URL:		https://github.com/stevearc/conform.nvim
--

return {
	"stevearc/conform.nvim",

	config = function()
		require("conform").setup({
			format_on_save = function(bufnr)
				if vim.bo[bufnr].filetype == "lua" then return end
				return { timeout_ms = 1000 }
			end,
			formatters_by_ft = {
				javascript = { "prettier", "dprint", stop_after_first = true },
				typescript = { "prettier", "dprint", stop_after_first = true },
				typescriptreact = { "prettier", "dprint", stop_after_first = true },
				javascriptreact = { "prettier", "dprint", stop_after_first = true },
				json = { "dprint" },
				lua = { "stylua" },
				markdown = { "dprint", "prettier", "mdformat", stop_after_first = true },
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
