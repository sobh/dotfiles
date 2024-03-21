-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.opt.laststatus = 3                  -- Global Status Line for all windows
vim.o.wrap = false			-- Disable wrapping long lines
-- Enable break indent for wrapped lines (Just in case)
vim.o.breakindent = true

-- Set Cursor Shape
vim.opt.guicursor = {
	'n-v-c-sm:block',
	'i-ci-ve:ver25-blinkon500-blinkoff500',
	'r-cr-o:hor20-blinkon500-blinkoff500',
}
vim.o.mouse = 'a'			-- Enable mouse mode

vim.o.textwidth = 80
vim.o.colorcolumn = '+1,+21,+41'	-- Highlight the end of 'textwidth'

-- Gutter
vim.o.number = true			-- Enable Line Numbers
vim.o.relativenumber = true		-- Show line numbers relative
vim.wo.signcolumn = 'yes'		-- Keep signcolumn on by default

-- Folding
vim.o.foldcolumn = '4'
vim.opt.fillchars:append { foldopen = '▼', foldclose = '►' }
vim.o.foldmethod='expr'
vim.o.foldexpr='nvim_treesitter#foldexpr()'
vim.o.foldlevel = 100


-- Tabs and Indentations -------------------------------------------------------
vim.o.tabstop     = 8      -- Number of spaces of the <Tab>
vim.o.shiftwidth  = 8      -- Number of spaces for indents ('cinednt', '<<', '>>')
vim.o.expandtab   = false  -- Do not expands <Tab> into spaces
vim.o.softtabstop = 8      -- Number of space of <Tab> while editing


---- Searching  ----------------------------------------------------------------
vim.o.hlsearch   = true   -- Highlihgt Search
vim.o.incsearch  = true   -- Incremental Search
-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase  = true

---- Other ---------------------------------------------------------------------
-- Set completeopt to have a better completion experience
vim.opt.completeopt = { 'menu', 'menuone', 'preview', 'noselect' }

vim.o.undofile = true   -- Save undo history

-- Timeout options are set by which-key
vim.o.timeout = true   -- Enable timeout
vim.o.timeoutlen = 300   -- Key Sequence timeout in mSec

-- Sync clipboard between OS and Neovim.
-- vim.o.clipboard = 'unnamedplus'

