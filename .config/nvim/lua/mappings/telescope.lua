---- Telescope -----------------------------------------------------------------
-- See `:help telescope.builtin`
local telescope = require('telescope.builtin')
return {
	n = {
		['<leader>'] = {
			[' '] = { telescope.buffers,     '[ ] Find existing Buffer' },
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
				name = 'Fuzzy/File Finder' ,
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
}

