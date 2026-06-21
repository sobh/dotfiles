-- Package:	avante.nvim
-- Description:	Cursor Like Experience
-- URL:		https://github.com/
--

return {
	"yetone/avante.nvim",
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	-- ⚠️ must add this setting! ! !
	build = vim.fn.has("win32") ~= 0
	    and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
	    or "make",
	event = "VeryLazy",
	keys = {
		{ '<leader>aa', '<cmd>AvanteToggle<cr>', mode = { 'n', 'v' }, desc = 'AI Chat toggle' },
		{ '<leader>ae', '<cmd>AvanteEdit<cr>', mode = { 'v' }, desc = 'AI edit selection' },
		{ '<leader>ar', '<cmd>AvanteRefresh<cr>', desc = 'AI refresh UI' },
	},
	version = false, -- Never set this value to "*"! Never!
	---@module 'avante'
	---@type avante.Config
	opts = {
		-- add any opts here
		-- this file can contain specific instructions for your project
		instructions_file = "avante.md",
		provider = "kiro",
		acp_providers = {
			kiro = {
				command = vim.fn.exepath("kiro-cli") or "kiro-cli",
				args = { "acp" },
				env = {
					PATH = os.getenv("PATH"),
				},
			},
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",

		-- Optional Dependencies
		"nvim-mini/mini.pick", -- for file_selector provider mini.pick
		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		"ibhagwan/fzf-lua", -- for file_selector provider fzf
		"stevearc/dressing.nvim", -- for input provider dressing
		"folke/snacks.nvim", -- for input provider snacks
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		-- "zbirenbaum/copilot.lua", -- for providers='copilot'
		-- {
		-- 	-- support for image pasting
		-- 	"HakonHarnes/img-clip.nvim",
		-- 	event = "VeryLazy",
		-- 	opts = {
		-- 		-- recommended settings
		-- 		default = {
		-- 			embed_image_as_base64 = false,
		-- 			prompt_for_file_name = false,
		-- 			drag_and_drop = {
		-- 				insert_mode = true,
		-- 			},
		-- 			-- required for Windows users
		-- 			use_absolute_path = true,
		-- 		},
		-- 	},
		-- },
		{
			-- Make sure to set this up properly if you have lazy=true
			'MeanderingProgrammer/render-markdown.nvim',
			opts = {
				file_types = { "markdown", "Avante" },
				render_modes = true,
			},
			ft = { "markdown", "Avante" },
			config = function(_, opts)
				require('render-markdown').setup(opts)
				-- Disable by default for markdown files; toggle with :RenderMarkdown toggle
				vim.api.nvim_create_autocmd("FileType", {
					pattern = "markdown",
					callback = function(ev)
						require('render-markdown').disable(ev.buf)
					end,
				})
			end,
		},
	},
}
