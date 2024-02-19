-- Package:	lsp-zero
-- URL:		https://github.com/VonHeikemen/lsp-zero.nvim
-- Description:	A starting point to setup some lsp related features in neovim.
--
return {
	'VonHeikemen/lsp-zero.nvim',
	branch = 'v2.x',
	dependencies = {
		-- LSP Support
		{'neovim/nvim-lspconfig'},		-- Required
		{					-- Optional
			'williamboman/mason.nvim',
			build = function()
				pcall(vim.cmd, 'MasonUpdate')
			end,
		},
		{'williamboman/mason-lspconfig.nvim'},	-- Optional

		-- Autocompletion
		{'hrsh7th/nvim-cmp'},		-- Required
		{'hrsh7th/cmp-nvim-lsp'},	-- Required
		{'L3MON4D3/LuaSnip'},		-- Required
	},
	config = function()
		---- lsp-config ------------------------------------------------
		local lsp_zero = require('lsp-zero')
		lsp_zero.preset({})
		-- Fix Undefined global 'vim'
		lsp_zero.nvim_workspace()
		lsp_zero.on_attach(function(client, bufnr)
			lsp_zero.default_keymaps({buffer = bufnr})
		end)
		---- nvim-cmp --------------------------------------------------
		local cmp = require('cmp')


		lsp_zero.setup()

	end,
}
