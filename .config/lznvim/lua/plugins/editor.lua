-- Description:	Editor Plugins Overrides.
--

return {
	{
		"hedyhli/outline.nvim",
		keys = function()
			-- Load my keymappings
			require("sobh.mappings").load("editor.outline")
			-- Override LazyVim default mappings
			return {}
		end,
	},
}
