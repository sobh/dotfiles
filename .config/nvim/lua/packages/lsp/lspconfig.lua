-- Package:	lspconfig
-- Description:	Quickstart configs for Nvim LSP
--              servers, linters, and formatters.
-- URL:		https://github.com/neovim/nvim-lspconfig
--

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		'hrsh7th/cmp-nvim-lsp', -- Language Server Protocol (LSP)
		'folke/neodev.nvim',    -- Configure LSP for NeoVim init.lua, and plugin developement.
	},

	config = function()

		require('neodev').setup({})

		local lspconfig = require("lspconfig")

		-- LSP & Completion Integration
		-- local capabilities_lsp = vim.lsp.protocol.make_client_capabilities()
		local capabilities = require('cmp_nvim_lsp').default_capabilities()

		local on_attach = function(_, bufnr)
			-- Load Key Mappings only to the attached buffers
			require("mappings").load("lsp", {buffer=bufnr})

			-- Create a command `:Format` local to the LSP buffer
			vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
				vim.lsp.buf.format()
			end, { desc = "Format current buffer with LSP" })
		end

		local servers = {
			clangd = {},
			-- gopls = {},
			-- rust_analyzer = {},
			-- tsserver = {},

			lua_ls = {
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
				},
			},
			pyright = {},
		}

		-- Configure the LSP Servers
		for server in pairs(servers) do
			lspconfig[server].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end
	end,
}
