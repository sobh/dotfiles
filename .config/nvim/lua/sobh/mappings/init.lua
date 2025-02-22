-- Description:	Central Key Mappings
-- Key mapping uses 'folke/which-key.nvim'

local M = {}
---- Requires ----------------------------------------------------------------------------------------------------------
local wk = require('which-key')

---- Options -----------------------------------------------------------------------------------------------------------
M.hrn = { left="h", down="j", up="k", right="l" }
M.home_row_nav = M.hrn

---- Functions ---------------------------------------------------------------------------------------------------------

local tbl_extend =function (dest, src)
	local ret = vim.deepcopy(dest)
	for k,v in pairs(src) do
		if type(k) == "number" then
			table.insert(ret, v)
		else
			ret[k] = v
		end
	end
	return ret
end
local function parse_map(map)
	local opts = {}
	local sub_maps = vim.deepcopy(map)
	local opt_keys = { 'desc', 'group', 'mode', 'cond', 'hidden', 'icon', 'proxy' }
	-- Extract Options from Sub-maps
	for _, o in ipairs(opt_keys) do
		opts[o] = map[o]
		sub_maps[o] = nil
	end
	-- Extract RHS
	local rhs = sub_maps[1]
	sub_maps[1] = nil

	if next(sub_maps) == nil then
		sub_maps = nil
	end
	return rhs, sub_maps, opts
end


local function transform_keymap_to_wkspec(keymap, prefix)
	local ret = {}
	prefix = prefix or ""
	for lhs, value in pairs(keymap) do
		lhs = prefix .. lhs
		if type(value) ~= "table" then
			vim.print("LHS = "..lhs)
			vim.print(value)
		end
		local rhs, sub_maps, opts = parse_map(value)
		local map = { lhs, rhs }
		if opts ~= nil then
			map = vim.tbl_extend('error', map, opts)
		end
		if sub_maps ~= nil then
			local parsed_submap = transform_keymap_to_wkspec(sub_maps, lhs)
			map = tbl_extend(map, parsed_submap)
		end
		table.insert(ret, map)
	end
	return ret
end

local function transform_modemap_to_wkspec(mode_map)
	local wkspec = {}
	for mode, map_tree in pairs(mode_map) do
		local flat_map = transform_keymap_to_wkspec(map_tree)
		flat_map.mode = mode
		table.insert(wkspec, flat_map)
	end
	return wkspec
end

M.set = function(mkeymap, opts)
	for mode, keymap in pairs(mkeymap) do
		if type(opts) == 'table'  then
			opts['mode'] = mode
		else
			opts = { mode=mode }
		end
		wk.register(vim.deepcopy(keymap), opts)
	end
end

-- Loads Package Mappings
M.load = function(name, opts)
	opts = opts or {}
	local keys
	if type(name) == 'string' then
		keys = require('sobh.mappings.plugins.'..name)
	elseif type(name) == 'table' then
		keys = name
	end
	local wkmap = transform_modemap_to_wkspec(keys)
	wkmap = vim.tbl_extend('error', wkmap, opts)
	wk.add(wkmap)

	-- M.set(keys, opts)
end

-- Setup Our Keymaps
M.setup = function ()
	local map = vim.keymap.set
	local up   = M.hrn.up
	local down = M.hrn.down

	local mappings = {
		n = {
			['<leader>'] = {
				c = {
					group='Configuration / Code',
					d = { function() vim.cmd.cd(vim.fn.stdpath('config')) end, desc='[C]onfiguration [D]irectory' },
					e = { '<cmd> vsplit $MYVIMRC <cr>', desc='[C]onfiguration [E]dit' },
				},
				g = {
					group = "Git",
				},
				p = {
					group='Project Navigation  ',
					v = { vim.cmd.Ex, desc='[P]roject [V]iew' },
				},
				s = {  [[:%s/\<<C-r><C-w>\>/]] , desc='Substitute Word Under Cursor' },
			},
			[']'] = { group='Various Motions' },
			['g'] = { group='Go To' },
		}
	}
	-- M.load(mappings)
	wk.add(transform_modemap_to_wkspec(mappings))

	map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
	-- Save, and Run Script
	map({'i', 'n'}, '<F2>', '<esc><cmd>w<CR> <cmd>!%:p<CR>', { desc = 'Execute Current File' })
	---- Trick Maps ----------------------------------------------------------------
	-- Faster Insert -> Normal Transitions
	map('i', down..up, '<esc>')
	map('i', down..down, '<esc>')
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
	map('n', up,    "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
	map('n', down,  "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

	---- Diagnostic keymaps --------------------------------------------------------
	-- map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
	-- map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
	-- map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
	-- map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
end

return M
