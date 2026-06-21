local map = vim.keymap.set

return function(opts)
	map('x', 'ga', '<Plug>(LiveEasyAlign)', { desc = 'Align Text' })
end
