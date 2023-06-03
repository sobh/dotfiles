---- Mapping - LSP -------------------------------------------------------------
local lsp_desc = 'LSP: '
return {
	n ={
		['<leader>'] = {
			l = {
				name = 'LSP',
				r = { vim.lsp.buf.rename, lsp_desc..'[R]name' }
			},
			w = { name='Workspace' },
		}
	}
}
