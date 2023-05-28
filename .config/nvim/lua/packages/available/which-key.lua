-- Package:	Which-Key
-- Description:	Display oa popup with possible key bindings of the typed
--		command.
-- URL:		https://github.com/folke/which-key.nvim
--
return {
	'folke/which-key.nvim', opts = {},
	event = "VeryLazy",
	init = function()
		-- Timeout
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	config = function()
		local wk = require('which-key')
		local mappings = require('mappings').which_key
		wk.register(mappings)
	end,
}

