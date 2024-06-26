-- Package:	nvim-cmp
-- Description:	Completion Engine
-- URL:		https://github.com/hrsh7th/nvim-cmp
-- Derived From:
--	- https://github.com/nvim-lua/kickstart.nvim
--
return {
	-- Autocompletion
	'hrsh7th/nvim-cmp',

	dependencies = {
		-- Snippet Engine to provide snippet recommandation in completion
		'L3MON4D3/LuaSnip',

		-- Sources
		'hrsh7th/cmp-buffer',           -- Text within the current buffer
		'hrsh7th/cmp-nvim-lsp',         -- Language Server Protocol (LSP)
		'hrsh7th/cmp-path',             -- File System pahts/directories
		'rafamadriz/friendly-snippets', -- Some Useful snippets
		'saadparwaiz1/cmp_luasnip',     -- LuaSnip source for nvim-cmp
	},

	config = function()
		-- See `:help cmp`
		local cmp = require('cmp')
		local luasnip = require('luasnip')

		-- Load VSCode style snippets (ex. 'friendly-snippets' plugin)
		require('luasnip.loaders.from_vscode').lazy_load()
		luasnip.config.setup({})

		cmp.setup({
			-- Use LuaSnip for snippets
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,

			},

			mapping = cmp.mapping.preset.insert {
				['<C-j>'] = cmp.mapping.select_next_item(),
				['<C-k>'] = cmp.mapping.select_prev_item(),
				['<C-i>'] = cmp.mapping.scroll_docs(-4),
				['<C-u>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-f>'] = cmp.mapping.abort(),            -- Close the complete window.
				['<CR>'] = cmp.mapping.confirm {
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				},
				['<Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { 'i', 's' }),
				['<S-Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { 'i', 's' }),
			},

			-- Completion Sources ordered by priority of the recommandation
			sources = {
				{ name = 'nvim_lsp' },  -- LSP
				{ name = 'luasnip' },   -- Snippets
				{ name = 'buffer' },    -- Buffer Text
				{ name = 'path' },      -- File system paths
			},

		})

	end,
}
