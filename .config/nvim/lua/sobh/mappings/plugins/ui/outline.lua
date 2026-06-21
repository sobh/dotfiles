local map = vim.keymap.set

return function(opts)
	opts = opts or {}
	local o = function(desc) return vim.tbl_extend('force', opts, { desc = desc }) end

	map('n', '<leader>ot', '<cmd>Outline<cr>',      o('Toggle Outline'))
	map('n', '<leader>of', '<cmd>OutlineFocus<cr>', o('Focus Outline'))
end
