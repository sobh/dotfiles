---- Code Formatter : conform.nvim ---------------------------------------------
local conform = require("conform")
return {
	n = {
		["<leader>"] = {
			c = {
				f = { conform.format,  desc = "[C]ode [F]ormat" },
			},
		},
	},
}
