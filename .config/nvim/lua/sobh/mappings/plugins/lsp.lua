local map = vim.keymap.set
local ts = require('telescope.builtin')

return function(opts)
	opts = opts or {}
	local o = function(desc) return vim.tbl_extend('force', opts, { desc = desc }) end

	-- Goto
	map('n', 'gd', vim.lsp.buf.definition,      o('LSP: Goto Definition'))
	map('n', 'gD', vim.lsp.buf.declaration,     o('LSP: Goto Declaration'))
	map('n', 'gi', vim.lsp.buf.implementation,  o('LSP: Goto Implementation'))
	map('n', 'gr', ts.lsp_references,           o('LSP: Goto References'))
	map('n', 'gy', vim.lsp.buf.type_definition, o('LSP: Goto Type Definition'))

	-- Symbols
	map('n', '<leader>cs', ts.lsp_document_symbols,          o('LSP: Document Symbols'))
	map('n', '<leader>cS', ts.lsp_dynamic_workspace_symbols, o('LSP: Workspace Symbols'))

	-- Info
	map('n', 'K',      vim.lsp.buf.hover,          o('LSP: Hover Documentation'))
	map('n', '<C-k>',  vim.lsp.buf.signature_help, o('LSP: Signature Help'))

	-- Actions
	map('n', '<leader>cr', vim.lsp.buf.rename,      o('LSP: Rename'))
	map('n', '<leader>ca', vim.lsp.buf.code_action, o('LSP: Code Action'))

	-- Workspace
	map('n', '<leader>cwa', vim.lsp.buf.add_workspace_folder,    o('LSP: Workspace Add Folder'))
	map('n', '<leader>cwr', vim.lsp.buf.remove_workspace_folder, o('LSP: Workspace Remove Folder'))
	map('n', '<leader>cwl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, o('LSP: Workspace List Folders'))
end
