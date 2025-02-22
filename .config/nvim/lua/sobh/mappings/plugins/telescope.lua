---- Telescope -----------------------------------------------------------------
-- See `:help telescope.builtin`
local telescope = require("telescope.builtin")
return {
	n = {
		["<leader>"] = {
			[" "] = { telescope.buffers, desc = "[ ] Find existing Buffer" },
			["/"] = {
				function()
					-- You can pass additional configuration to telescope to change theme, layout, etc.
					require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
						winblend = 10,
						previewer = false,
					}))
				end,
				desc = "[/] Fuzzily search in current buffer",
			},
			f = {
				group = "Fuzzy/File Finder",
				-- b = { telescope.buffers,     "[F]ind [B]uffer" },
				d = { telescope.diagnostics, desc = "[F]ind [D]ignostics" },
				f = { telescope.find_files,  desc = "[F]ind [F]iles" },
				g = { telescope.git_files,   desc = "[F]ind [G]it Files" },
				h = { telescope.help_tags,   desc = "[F]ind [H]elp" },
				r = { telescope.oldfiles,    desc = "[F]ind [R]ecently Opened Files" },
				s = { telescope.live_grep,   desc = "[F]ind [S]tring in Files" },
				w = { telescope.grep_string, desc = "[F]ind [W]ord under cursor in Files" },
			},
			g = {
				group = "Git",
				c = { telescope.git_commits, desc = "Commits" },
				a = { telescope.git_status,  desc = "Status" },
			},
		},
	},
}
