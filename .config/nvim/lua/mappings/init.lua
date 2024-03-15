-- Description:	Central Key Mappings
-- Key mapping uses 'folke/which-key.nvim'

local M = {}
---- Requires ----------------------------------------------------------------------------------------------------------
local wk = require('which-key')

---- Functions ---------------------------------------------------------------------------------------------------------

M.set = function(mkeymap, opts)
	for mode, keymap in pairs(mkeymap) do
		if type(opts) == 'table'  then
			opts['mode'] = mode
		else
			opts = { mode=mode }
		end
		wk.register(keymap, opts)
	end
end

-- Loads Package Mappings
M.load = function(name, opts)
	local keys
	if type(name) == 'string' then
		keys = require('mappings.'..name)
	elseif type(name) == 'table' then
		keys = name
	end

	M.set(keys, opts)
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
			p = {
				name='Project Navigation  ',
				v = { vim.cmd.Ex, '[P]roject [V]iew' },
			},
			s = {  [[:%s/\<<C-r><C-w>\>/]] , 'Substitute Word Under Cursor' },
		},
		[']'] = { name='Various Motions' }
	}
}

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Save, and Run Script
vim.keymap.set({'i', 'n'}, '<F2>', '<esc><cmd>w<CR> <cmd>!%:p<CR>', { desc = 'Execute Current File' })



---- Trick Maps ----------------------------------------------------------------
-- Faster Insert -> Normal Transitions
vim.keymap.set('i', 'jk', '<esc>')
vim.keymap.set('i', 'jj', '<esc>')
-- Faster Command Mode
vim.keymap.set({'n','v'}, ';', ':')
vim.keymap.set({'n','v'}, ':', ';')

---- Movement and Navigation ---------------------------------------------------
vim.keymap.set('n', '<S-Tab>', '<cmd> b#<CR>', { desc = 'Switch to recent buffers'})
-- Scrolling using CTRL-{jk}
vim.keymap.set('n', '<C-j>', '<C-e>', { desc = 'Scroll Downward' })
vim.keymap.set('n', '<C-k>', '<C-y>', { desc = 'Scroll Upwards' })
--

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

---- Diagnostic keymaps --------------------------------------------------------
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })


return M
