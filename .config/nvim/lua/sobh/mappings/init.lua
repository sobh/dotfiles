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
		keys = require('sobh.mappings.plugins.'..name)
	elseif type(name) == 'table' then
		keys = name
	end

	M.set(keys, opts)
end

-- Setup Our Keymaps
M.setup = function ()
	local map = vim.keymap.set
	local mappings = {
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
	M.load(mappings)

	map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
	-- Save, and Run Script
	map({'i', 'n'}, '<F2>', '<esc><cmd>w<CR> <cmd>!%:p<CR>', { desc = 'Execute Current File' })
	---- Trick Maps ----------------------------------------------------------------
	-- Faster Insert -> Normal Transitions
	map('i', 'jk', '<esc>')
	map('i', 'jj', '<esc>')
	-- Faster Command Mode
	map({'n','v'}, ';', ':')
	map({'n','v'}, ':', ';')
	map('n', 'q;', 'q:')
	-- Clear search with <esc>
	map({'i', 'n'}, '<esc>', '<cmd>nohlsearch<cr><esc>', { desc= 'Escape, and clear hlsearch' })

	---- Movement and Navigation ---------------------------------------------------
	map('n', '<S-Tab>', '<cmd> b#<CR>', { desc = 'Switch to recent buffers'})
	-- Scrolling using CTRL-{jk}
	-- map('n', '<C-j>', '<C-e>', { desc = 'Scroll Downward' })
	-- map('n', '<C-k>', '<C-y>', { desc = 'Scroll Upwards' })
	--

	-- Remap for dealing with word wrap
	map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
	map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

	---- Diagnostic keymaps --------------------------------------------------------
	-- map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
	-- map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
	-- map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
	-- map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
end

return M
