local map = vim.keymap.set
local ts = require('telescope.builtin')

return function(opts)
	opts = opts or {}
	local o = function(desc) return vim.tbl_extend('force', opts, { desc = desc }) end

	map('n', '<leader> ', ts.buffers,     o('Find existing Buffer'))
	map('n', '<leader>/', function()
		ts.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
			winblend = 10,
			previewer = false,
		}))
	end, o('Search current buffer'))
	map('n', '<leader>?', ts.live_grep, o('Search workspace'))

	map('n', '<leader>fd', ts.diagnostics, o('Find Diagnostics'))
	map('n', '<leader>ff', ts.find_files,  o('Find Files'))
	map('n', '<leader>fg', ts.git_files,   o('Find Git Files'))
	map('n', '<leader>fh', ts.help_tags,   o('Find Help'))
	map('n', '<leader>fr', ts.oldfiles,    o('Find Recently Opened Files'))
	map('n', '<leader>m',  ts.keymaps,     o('Search Keymaps'))
	map('n', '<leader>fw', function()
		ts.current_buffer_fuzzy_find({ default_text = vim.fn.expand('<cword>') })
	end, o('Find Word in buffer'))
	map('n', '<leader>fW', function()
		ts.grep_string()
	end, o('Find Word in workspace'))

	map('n', '<leader>gc', ts.git_commits, o('Git Commits'))
	map('n', '<leader>ga', ts.git_status,  o('Git Status'))
end
