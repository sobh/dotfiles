-- Description:	Central Key Mappings
-- Key mapping uses 'folke/which-key.nvim'
local M = {}


vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

---- Project Navigation
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = '[P]roject [V]iew' })

-- Configuration
vim.keymap.set('n', '<leader>ce', '<cmd> vsplit $MYVIMRC <cr>', { desc = '[C]onfiguration [E]dit' })

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



---- Package Mappings --------------------------------------------------------------------------------------------------
---- Telescope -----------------------------------------------------------------
-- See `:help telescope.builtin`
local ok, telescope = pcall(require, 'telescope.builtin')
if ok then
	M.telescope = {
		['<leader>'] = {
			[' '] = { telescope.buffers,     '[] Find existing Buffer' },
			['/'] = {
				function()
					-- You can pass additional configuration to telescope to change theme, layout, etc.
					require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
						winblend = 10,
						previewer = false,
					})
				end,
				'[/] Fuzzily search in current buffer'
			},
			f = {
				name = 'Fuzzy Finder' ,
				-- b  = { builtin.buffers,     '[F]ind [B]uffer' },
				d  = { telescope.diagnostics, '[F]ind [D]ignostics' },
				f  = { telescope.find_files,  '[F]ind [F]iles' },
				g  = { telescope.git_files,   '[F]ind [G]it Files'},
				h  = { telescope.help_tags,   '[F]ind [H]elp'},
				r  = { telescope.oldfiles,    '[F]ind [R]ecently Opened Files' },
				s  = { telescope.live_grep,   '[F]ind [S]tring in Files' },
				w  = { telescope.grep_string, '[F]ind [W]ord under cursor in Files' },
			}
		}
	}
else
	telescope = nil
end

---- LSP -----------------------------------------------------------------------
local lsp_desc = 'LSP: '
M.lsp = {
	['<leader>'] = {
		l = {
			name = 'LSP',
			r = { vim.lsp.buf.rename, lsp_desc..'[R]name' }
		}
	}
}

---- Which-Keys ----------------------------------------------------------------
M.which_key = {
	['<leader>'] = {
		c = 'Configuration',
		p = 'Project',
	},
}

return M
