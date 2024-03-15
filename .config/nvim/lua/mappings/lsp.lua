---- Mapping - LSP -------------------------------------------------------------
local lsp_desc = 'LSP: '
local ts_builtin = require('telescope.builtin')
return {
	n ={
		['<leader>'] = {
			l = {
				name = 'LSP',
				r = { vim.lsp.buf.rename, lsp_desc..'[R]name' },
				c = { vim.lsp.buf.code_action, lsp_desc..'[C]ode Action' },
				w = {
					name='Workspace',
					a = { vim.lsp.buf.add_workspace_folder, lsp_desc..'[W]orkspace [A]dd Folder' },
					r = { vim.lsp.buf.remove_workspace_folder, lsp_desc..'[W]orkspace [R]emove Folder' },
					l = {
						function ()
							print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
						end,
						'[W]orkspace [L]ist Folders'
					},
				},
			},
		},

		g = {
			d = { vim.lsp.buf.definition, lsp_desc..'[G]oto [D]efinition' },
			D = { vim.lsp.buf.declaration, lsp_desc..'[G]oto [D]eclaration' },
			i = { vim.lsp.buf.implementation, lsp_desc..'[G]oto [I]mplemenation' },
			r = { ts_builtin.lsp_references, lsp_desc..'[G]oto [R]eferences' },
		},

		-- See `:help K` for why this keymap
		K = { vim.lsp.buf.hover, lsp_desc..'Hover Documentation' },
		['<C-k>'] = { vim.lsp.buf.signature_help, lsp_desc..'Signature Documentation' },
	}
}
-- 	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
-- 	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
