local map = vim.keymap.set
local fzf = require('fzf-lua')

return function(opts)
	opts = opts or {}
	local o = function(desc) return vim.tbl_extend('force', opts, { desc = desc }) end

	map('n', '<leader> ', fzf.buffers,    o('Find existing Buffer'))
	map('n', '<leader>/', fzf.blines,     o('Search current buffer'))
	map('n', '<leader>?', fzf.live_grep,  o('Search workspace'))

	map('n', '<leader>fd', fzf.diagnostics_workspace, o('Find Diagnostics'))
	map('n', '<leader>ff', fzf.files,      o('Find Files'))
	map('n', '<leader>fg', fzf.git_files,  o('Find Git Files'))
	map('n', '<leader>fh', fzf.helptags,   o('Find Help'))
	map('n', '<leader>fr', fzf.oldfiles,   o('Find Recently Opened Files'))
	map('n', '<leader>m',  fzf.keymaps,    o('Search Keymaps'))
	map('n', '<leader>fw', fzf.grep_cword, o('Find Word in buffer'))
	map('n', '<leader>fW', fzf.grep_cword, o('Find Word in workspace'))

	map('n', '<leader>gc', fzf.git_commits, o('Git Commits'))
	map('n', '<leader>ga', fzf.git_status,  o('Git Status'))
end
