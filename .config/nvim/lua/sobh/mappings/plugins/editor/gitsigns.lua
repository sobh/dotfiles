----- Editor : GitSigns --------------------------------------------------------
local gs = require("gitsigns")
-- Normal Mode
return {
	n = {
		["<leader>"] = {
			g = {
				name = "Git",
				b = { function() gs.blame_line{full=true} end, "Blame Line" },
				d = { gs.diffthis, "Diff This" },
				D = { function() gs.diffthis("~") end, "Diff This ~" },
				p = { gs.preview_hunk,    "Preview Hunk" },
				r = { gs.reset_hunk,      "Reset Hunk" },
				R = { gs.reset_buffer,    "Reset Buffer" },
				s = { gs.stage_hunk,      "Stage Hunk" },
				S = { gs.stage_buffer,    "Stage Buffer" },
				u = { gs.undo_stage_hunk, "Undo Stage Hunk" },
				t = {
					name = "Toggle",
					b = { gs.toggle_current_line_blame, "Blame" },
					d = { gs.toggle_deleted, "Deleted" },
					l = { gs.toggle_linehl, "Line Highlight" },
					w = { gs.toggle_word_diff, "Word Diff" },
				},
			},
		},
	},
	v = {
		g = {
			name = "Git",
			s = { function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, "Stage Hunk" },
			r = { function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, "Reset Hunk" },
		},
	},
	-- Text Objects
	x = { ih = { ":<C-U>Gitsigns select_hunk<cr>", "Select Hunk" } } ,
	o = { ih = { ":<C-U>Gitsigns select_hunk<cr>", "Select Hunk" } } ,
}
