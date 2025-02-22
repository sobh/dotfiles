---- File Explorer : nvim-tree.lua ---------------------------------------------
-- :help nvim-tree-commands
local explorer = require('nvim-tree.api')
local fn = {
	collapse = function()
		explorer.tree.collapse_all(false)
	end,
}
return {
	n = {
		['<leader>'] = {
			e = {
				group = 'Explorer',
				e = { explorer.tree.toggle, desc = '[E]xplorer [E]xpand/Toggle' },
				f = { explorer.tree.focus,  desc = '[E]xplorer [F]ocus' },
				s = { explorer.tree.toggle, desc = '[E]xplorer [S]ync: Buffer to Explorer' },
				c = { fn.collapse,          desc = '[E]xplorer [C]ollapse Tree' },
			}
		}
	}
}

