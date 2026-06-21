-- Package:	agentic.nvim
-- Description:	ACP-based AI chat interface.
-- URL:		https://github.com/carlos-algms/agentic.nvim

return {
	'carlos-algms/agentic.nvim',
	opts = {
		provider = 'kiro-acp',
	},
	keys = {
		{ '<leader>aa', function() require('agentic').toggle() end, mode = { 'n', 'v' }, desc = 'AI Chat toggle' },
		{ '<leader>ae', function() require('agentic').add_selection_or_file_to_context() end, mode = { 'n', 'v' }, desc = 'AI add to context' },
		{ '<leader>an', function() require('agentic').new_session() end, mode = { 'n' }, desc = 'AI new session' },
	},
}
