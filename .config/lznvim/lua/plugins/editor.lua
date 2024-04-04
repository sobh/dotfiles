-- Description:	Editor Plugins Overrides.
--

return {
	{
		"hedyhli/outline.nvim",
		keys = function(_, opts)
			return {
				{ "<leader>ot", "<cmd>Outline<cr>", desc = "Toggle Outline" },
				{ "<leader>of", "<cmd>OutlineFocus<cr>", desc = "Focus Outline" },
			}
		end,
	},
}
