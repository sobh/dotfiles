-- Package:     blink.indent
-- Description: Performant indent guides
-- URL:         https://github.com/saghen/blink.indent

return {
	'saghen/blink.indent',
	event = 'BufReadPost',
	opts = {
		scope = { enabled = true },
	},
}
