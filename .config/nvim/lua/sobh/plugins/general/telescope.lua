-- Package: https://github.com/nvim-telescope/telescope.nvim

return {
	-- Fuzzy Finder (files, lsp, etc)
	"nvim-telescope/telescope.nvim",
	branch = "master",
	dependencies = {
		-- Required
		"nvim-lua/plenary.nvim",
		-- Optional
		"nvim-tree/nvim-web-devicons",
		-- For Key Mappings
		"folke/which-key.nvim",
	},
	config = function()
		-- Requires
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		-- Configuration
		telescope.setup({
			defaults = {
				sorting_strategy = "ascending",
				layout_config = {
					prompt_position = "top",
				},
				mappings = {
					i = {
						-- Cycle through selections using home row keys
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
				},
			},
			pickers = {
				find_files = {
					follow = true, -- Follow symlinks
				},
			},
		})
		-- Load Key Mappings
		require("sobh.mappings").load("telescope")

		-- Enable telescope fzf native, if installed
		pcall(require("telescope").load_extension, "fzf")
	end,
}
