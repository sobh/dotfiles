-- Description: This files contains the general options of NeoVim
local M = {}
M.setup = function ()
	local o = vim.opt

	-- NOTE: You should make sure your terminal supports this
	o.termguicolors = true

	o.laststatus = 3                  -- Global Status Line for all windows
	o.wrap = false			-- Disable wrapping long lines
	-- Enable break indent for wrapped lines (Just in case)
	o.breakindent = true

	-- Set Cursor Shape
	o.guicursor = {
		'n-v-c-sm:block',
		'i-ci-ve:ver25-blinkon500-blinkoff500',
		'r-cr-o:hor20-blinkon500-blinkoff500',
	}
	o.mouse = 'a'			-- Enable mouse mode

	o.textwidth = 80
	o.colorcolumn = '+1,+21,+41'	-- Highlight the end of 'textwidth'

	-- Gutter
	o.number = true			-- Enable Line Numbers
	o.relativenumber = true		-- Show line numbers relative
	vim.wo.signcolumn = 'yes'		-- Keep signcolumn on by default

	-- Folding
	o.foldcolumn = '4'
	o.fillchars:append { foldopen = '▼', foldclose = '►' }
	o.foldmethod='expr'
	o.foldexpr='nvim_treesitter#foldexpr()'
	o.foldlevel = 100


	-- Tabs and Indentations -------------------------------------------------------
	o.tabstop     = 8      -- Number of spaces of the <Tab>
	o.shiftwidth  = 8      -- Number of spaces for indents ('cinednt', '<<', '>>')
	o.expandtab   = false  -- Do not expands <Tab> into spaces
	o.softtabstop = 8      -- Number of space of <Tab> while editing


	---- Searching  ----------------------------------------------------------------
	o.hlsearch   = true   -- Highlihgt Search
	o.incsearch  = true   -- Incremental Search
	-- Case insensitive searching UNLESS /C or capital in search
	o.ignorecase = true
	o.smartcase  = true

	---- Other ---------------------------------------------------------------------
	-- Set completeopt to have a better completion experience
	o.completeopt = { 'menu', 'menuone', 'preview', 'noselect' }

	o.undofile = true   -- Save undo history

	-- Timeout options are set by which-key
	o.timeout = true   -- Enable timeout
	o.timeoutlen = 300   -- Key Sequence timeout in mSec

	-- Sync clipboard between OS and Neovim.
	-- vim.o.clipboard = 'unnamedplus'


end
return M
