-- Description: This files contains the general options of NeoVim
local M = {}

M.setup = function ()
	local o = vim.opt
	local tty = require('sobh.utils').is_tty()

	if not tty then
		o.termguicolors = true
		o.guicursor = {
			'n-v-c-sm:block-Cursor/lCursor',
			'i-ci-ve:ver25-blinkon500-blinkoff500-Cursor/lCursor',
			'r-cr-o:hor20-blinkon500-blinkoff500-Cursor/lCursor',
		}
	end

	o.laststatus = 3                -- Global Status Line for all windows
	o.cursorline = true             -- Highlight current line
	o.showcmd = true                -- Show command being typed
	o.wrap = false			-- Disable wrapping long lines
	-- Enable break indent for wrapped lines (Just in case)
	o.breakindent = true

	-- List mode
	o.list = false
	o.listchars = { tab = "├─❭", space = "·" }

	o.mouse = 'a'			-- Enable mouse mode

	o.textwidth = 80
	o.colorcolumn = '+1,+21,+41'	-- Highlight the end of 'textwidth'

	-- Gutter
	o.number = true			-- Enable Line Numbers
	o.relativenumber = true		-- Show line numbers relative
	vim.wo.signcolumn = 'yes'       -- Keep signcolumn on by default

	-- Folds ---------------------------------------------------------------
	local icons = require('sobh.config.icons')
	o.foldcolumn = '1'
	o.fillchars:append { foldopen = icons.fold.open, foldclose = icons.fold.close, foldsep = icons.fold.sep }
	o.foldmethod = 'expr'
	o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
	o.foldtext = ''
	o.foldlevel = 99
	o.foldlevelstart = 99


	-- Tabs and Indentations -----------------------------------------------
	o.tabstop     = 8      -- Number of spaces of the <Tab>
	o.shiftwidth  = 8      -- Number of spaces for indents ('cinednt', '<<', '>>')
	o.expandtab   = false  -- Do not expands <Tab> into spaces
	o.softtabstop = 8      -- Number of space of <Tab> while editing


	---- Searching  --------------------------------------------------------
	o.hlsearch   = true   -- Highlihgt Search
	o.incsearch  = true   -- Incremental Search
	-- Case insensitive searching UNLESS /C or capital in search
	o.ignorecase = true
	o.smartcase  = true

	---- Other -------------------------------------------------------------
	-- Set completeopt to have a better completion experience
	o.completeopt = { 'menu', 'menuone', 'preview', 'noselect' }

	o.undofile = true   -- Save undo history

	-- Timeout options are set by which-key
	o.timeout = true   -- Enable timeout
	o.timeoutlen = 300   -- Key Sequence timeout in mSec

	-- Sync clipboard between OS and Neovim.
	-- vim.o.clipboard = 'unnamedplus'

	-- Spelling
	o.spelllang = 'en_us'
	o.spell = false  -- Enable per filetype via ftplugin or autocmd

end
return M
