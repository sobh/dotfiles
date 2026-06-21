local map = vim.keymap.set
local gs = require('gitsigns')

return function(opts)
	opts = opts or {}
	local o = function(desc) return vim.tbl_extend('force', opts, { desc = desc }) end

	map('n', '<leader>gB', function() gs.blame_line({ full = true }) end, o('Git Blame line popup'))
	map('n', '<leader>gd', gs.diffthis,       o('Git Diff against index'))
	map('n', '<leader>gp', gs.preview_hunk,   o('Git Preview Hunk'))
	map('n', '<leader>gr', gs.reset_hunk,     o('Git Reset Hunk'))
	map('n', '<leader>gR', gs.reset_buffer,   o('Git Reset Buffer'))
	map('n', '<leader>gs', gs.stage_hunk,     o('Git Stage Hunk'))
	map('n', '<leader>gS', gs.stage_buffer,   o('Git Stage Buffer'))
	map('n', '<leader>gu', gs.undo_stage_hunk, o('Git Undo Stage Hunk'))

	-- Toggles
	map('n', '<leader>gtb', gs.toggle_current_line_blame, o('Git Toggle Blame'))
	map('n', '<leader>gtd', gs.toggle_deleted,            o('Git Toggle Deleted'))
	map('n', '<leader>gtl', gs.toggle_linehl,             o('Git Toggle Line Highlight'))
	map('n', '<leader>gtw', gs.toggle_word_diff,          o('Git Toggle Word Diff'))

	-- Visual mode
	map('v', '<leader>gs', function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, o('Git Stage Hunk'))
	map('v', '<leader>gr', function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, o('Git Reset Hunk'))

	-- Text objects
	map({ 'x', 'o' }, 'ih', ':<C-U>Gitsigns select_hunk<cr>', o('Select Hunk'))
end
