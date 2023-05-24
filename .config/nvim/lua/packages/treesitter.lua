-- Package:	TreeSitter
-- URL:		https://github.com/nvim-treesitter/nvim-treesitter
-- Help:	`:help nvim-treesitter`
--

return {
	'nvim-treesitter/nvim-treesitter',
	dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
	build = function()
		require('nvim-treesitter.install').update({ with_sync = true })
	end,
	config = function()
		require('nvim-treesitter.configs').setup {
			-- Installed Languages
			ensure_installed = { 'c', 'cpp', 'go', 'javascript', 'lua', 'python', 'rust', 'vim', 'vimdoc', },
			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,

			-- Automatically install missing parsers when entering buffer
			-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
			auto_install = true,

			highlight = { enable = true },
		}
	end
}
