--- Key mappings module.
--- Global keymaps and a loader for plugin-specific keymaps.
---@module "sobh.mappings"

local M = {}

--- Load plugin-specific keymaps.
--- @param name string Plugin mapping module name (e.g. 'lsp', 'code.formatter')
--- @param opts? table Options passed to vim.keymap.set (e.g. { buffer = bufnr })
M.load = function(name, opts)
	require('sobh.mappings.plugins.' .. name)(opts)
end

--- Register global keymaps.
M.setup = function()
	local map = vim.keymap.set

	map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

	-- Swap ; and : for faster command mode
	map({ 'n', 'v' }, ';', ':')
	map({ 'n', 'v' }, ':', ';')

	-- Execute current file
	map('n', '<leader>x', '<cmd>w<CR><cmd>!%:p<CR>', { desc = 'Execute current file' })

	-- Faster Insert -> Normal Transitions
	map('i', 'jk', '<esc>')
	map('i', 'jj', '<esc>')

	-- Clear search with <esc>
	map({ 'i', 'n' }, '<esc>', '<cmd>nohlsearch<cr><cmd>fclose<cr><esc>', { desc = 'Escape and clear hlsearch' })

	-- Navigation
	map('n', '<S-Tab>', '<cmd>b#<CR>', { desc = 'Switch to recent buffer' })

	-- Remap for dealing with word wrap
	map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
	map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

	-- Configuration
	map('n', '<leader>.d', function() vim.cmd.cd(vim.fn.stdpath('config')) end, { desc = 'Config Directory' })
	map('n', '<leader>.e', '<cmd>vsplit $MYVIMRC<cr>', { desc = 'Config Edit' })
	map('n', '<leader>pv', vim.cmd.Ex, { desc = 'Project View' })
	map('n', '<leader>gD', function()
		local ref = vim.fn.input('Diff against (default HEAD): ')
		if ref == '' then ref = 'HEAD' end
		local file = vim.fn.system('git ls-files --full-name ' .. vim.fn.shellescape(vim.fn.expand('%'))):gsub('\n', '')
		local ft = vim.bo.filetype
		vim.cmd('diffthis')
		vim.cmd('botright vnew')
		vim.cmd('read !git show ' .. ref .. ':' .. file)
		vim.cmd('0d_')
		vim.bo.buftype = 'nofile'
		vim.bo.bufhidden = 'wipe'
		vim.bo.filetype = ft
		vim.cmd('diffthis')
		vim.cmd('wincmd p')
	end, { desc = 'Diff file against git ref' })
	map('n', '<leader>sw', [[:%s/\<<C-r><C-w>\>/]], { desc = 'Substitute word under cursor' })

	-- System clipboard (+ register)
	map({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Yank to system clipboard'           })
	map({ 'n' },      '<leader>Y', '"+Y', { desc = 'Yank line to system clipboard'      })
	map({ 'n', 'v' }, '<leader>p', '"+p', { desc = 'Paste from system clipboard'        })
	map({ 'n', 'v' }, '<leader>P', '"+P', { desc = 'Paste before from system clipboard' })

	-- Window management (<leader>w as prefix, which-key shows options)
	map('n', '<leader>wh', '<C-w>h', { desc = 'Window left' })
	map('n', '<leader>wj', '<C-w>j', { desc = 'Window down' })
	map('n', '<leader>wk', '<C-w>k', { desc = 'Window up' })
	map('n', '<leader>wl', '<C-w>l', { desc = 'Window right' })
	map('n', '<leader>ws', '<C-w>s', { desc = 'Window split horizontal' })
	map('n', '<leader>wv', '<C-w>v', { desc = 'Window split vertical' })
	map('n', '<leader>wq', '<C-w>q', { desc = 'Window close' })
	map('n', '<leader>wo', '<C-w>o', { desc = 'Window only (close others)' })
	map('n', '<leader>w=', '<C-w>=', { desc = 'Window equalize' })
	map('n', '<leader>ww', '<C-w>w', { desc = 'Window next' })
end

return M
