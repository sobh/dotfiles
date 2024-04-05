-- Package:     indent-blankline.nvim
-- Description: Indent guides for NeoVim
-- URL:         https://github.com/lukas-reineke/indent-blankline.nvim
--
return {
	'lukas-reineke/indent-blankline.nvim',
	main = 'ibl',
	-- Lazy Load after 'Syntax', to use the colorscheme defined
	-- highlights.
	lazy = true,
	event = 'Syntax',
	config = function()
		local ibl = require("ibl")
		local highlight = {
			"RainbowRed",
			"RainbowYellow",
			"RainbowBlue",
			"RainbowOrange",
			"RainbowGreen",
			"RainbowViolet",
			"RainbowCyan",
		}

		-- If the highlights are not supported by the used colorscheme,
		-- create the highlight groups in the highlight setup hook, so they are reset
		-- every time the colorscheme changes
		local hooks = require("ibl.hooks")
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			local is_defined_hl = (next(vim.api.nvim_get_hl(0, {name=highlight[1]})) == nil)
			if is_defined_hl then
				vim.api.nvim_set_hl(0, "RainbowRed",    { fg = "#E06C75" })
				vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
				vim.api.nvim_set_hl(0, "RainbowBlue",   { fg = "#61AFEF" })
				vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
				vim.api.nvim_set_hl(0, "RainbowGreen",  { fg = "#98C379" })
				vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
				vim.api.nvim_set_hl(0, "RainbowCyan",   { fg = "#56B6C2" })
			end
		end)

		ibl.setup {
			indent = { highlight = highlight },
			exclude = {
				filetypes = { "diff" },
			}
		}
	end,

}
