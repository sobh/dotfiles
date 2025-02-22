----- Editor : GitSigns --------------------------------------------------------
local gs = require("gitsigns")
-- Normal Mode
return {
	n = {
		["<leader>"] = {
			g = {
				group = "Git",
				b = { function() gs.blame_line{full=true} end, desc = "Blame Line" },
				d = { gs.diffthis, desc = "Diff This" },
				D = { function() gs.diffthis("~") end, desc = "Diff This ~" },
				p = { gs.preview_hunk,    desc = "Preview Hunk" },
				r = { gs.reset_hunk,      desc = "Reset Hunk" },
				R = { gs.reset_buffer,    desc = "Reset Buffer" },
				s = { gs.stage_hunk,      desc = "Stage Hunk" },
				S = { gs.stage_buffer,    desc = "Stage Buffer" },
				u = { gs.undo_stage_hunk, desc = "Undo Stage Hunk" },
				t = {
					group = "Toggle",
					b = { gs.toggle_current_line_blame, desc = "Blame" },
					d = { gs.toggle_deleted,            desc = "Deleted" },
					l = { gs.toggle_linehl,             desc = "Line Highlight" },
					w = { gs.toggle_word_diff,          desc = "Word Diff" },
				},
			},
		},
	},
	v = {
		g = {
			group = "Git",
			s = { function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, desc = "Stage Hunk" },
			r = { function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, desc = "Reset Hunk" },
		},
	},
	-- Text Objects
	x = { ih = { ":<C-U>Gitsigns select_hunk<cr>", desc = "Select Hunk" } } ,
	o = { ih = { ":<C-U>Gitsigns select_hunk<cr>", desc = "Select Hunk" } } ,
}
