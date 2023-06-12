-- Description:	Central Key Mappings
-- Key mapping uses 'folke/which-key.nvim'

local M = {}
---- Requires ----------------------------------------------------------------------------------------------------------
local wk = require('which-key')

---- Functions ---------------------------------------------------------------------------------------------------------

M.set = function(mkeymap)
	for mode, keymap in pairs(mkeymap) do
		wk.register(keymap, { mode = mode })
	end
end

-- Loads Package Mappings
M.load = function(name)
	local keys
	if type(name) == 'string' then
		keys = require('mappings.'..name)
	elseif type(name) == 'table' then
		keys = name
	end

	M.set(keys)
end

---- Keymaps -------------------------------------------------------------------
M.general = {
	n = {
		['<leader>'] = {
			c = {
				name='Configuration',
				d = { function() vim.cmd.cd(vim.fn.stdpath('config')) end, '[C]onfiguration [D]irectory' },
				e = { '<cmd> vsplit $MYVIMRC <cr>', '[C]onfiguration [E]dit' },
			},
			p = { name='Project' },
		},
	}
}

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

---- Project Navigation
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = '[P]roject [V]iew' })

-- Save, and Run Script
vim.keymap.set({'i', 'n'}, '<F2>', '<esc><cmd>w<CR> <cmd>!%:p<CR>', { desc = 'Execute Current File' })


-- Substitute word under cursor
-- vim.keymap.set('n', '<leader>s', ':%s/\<<C-r><C-w>\>/')

-- Faster Insert -> Normal Transitions
vim.keymap.set('i', 'jk', '<esc>')
vim.keymap.set('i', 'jj', '<esc>')
---- Movement and Navigation ---------------------------------------------------
vim.keymap.set('n', '<S-Tab>', '<cmd> b#<CR>', { desc = 'Switch to recent buffers'})
-- Scrolling using CTRL-{jk}
vim.keymap.set('n', '<C-j>', '<C-e>', { desc = 'Scroll Downward' })
vim.keymap.set('n', '<C-k>', '<C-y>', { desc = 'Scroll Upwards' })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

---- Diagnostic keymaps --------------------------------------------------------
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })


return M
