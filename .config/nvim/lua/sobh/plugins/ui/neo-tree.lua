-- Package:	neo-tree.nvim
-- Description:	File explorer sidebar.
-- URL:		https://github.com/nvim-neo-tree/neo-tree.nvim

return {
	'nvim-neo-tree/neo-tree.nvim',
	branch = 'v3.x',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-tree/nvim-web-devicons',
		'MunifTanjim/nui.nvim',
	},
	cmd = 'Neotree',
	keys = {
		{ '<leader>et', '<cmd>Neotree toggle<cr>', desc = 'Explorer toggle' },
		{ '<leader>ef', '<cmd>Neotree focus<cr>',  desc = 'Explorer focus' },
		{ '<leader>eg', function()
			local root = vim.fn.system('git rev-parse --show-toplevel'):gsub('\n', '')
			if root == vim.env.HOME then
				vim.notify('Refusing to scan home directory repo', vim.log.levels.WARN)
				return
			end
			vim.cmd('Neotree git_status')
		end, desc = 'Explorer git status' },
	},
	opts = {
		filesystem = {
			follow_current_file = { enabled = true },
			hijack_netrw_behavior = 'disabled',
		},
		git_status = {
			window = { position = 'float' },
		},
		event_handlers = {
			{
				event = 'neo_tree_buffer_enter',
				handler = function()
					vim.opt_local.signcolumn = 'no'
				end,
			},
		},
	},
}
