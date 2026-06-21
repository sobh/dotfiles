local map = vim.keymap.set
local conform = require('conform')

return function(opts)
	opts = opts or {}
	local o = function(desc) return vim.tbl_extend('force', opts, { desc = desc }) end

	map('n', '<leader>cf', conform.format, o('Code Format'))
	map('v', '<leader>cf', conform.format, o('Code Format'))
end
