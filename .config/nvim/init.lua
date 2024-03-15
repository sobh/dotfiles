--
-- Description:	NeoVim Lua Configruation.
-- Derived From:
-- 	https://github.com/ThePrimeagen/init.lua
-- 	https://github.com/nvim-lua/kickstart.nvim
-- 	https://github.com/LazyVim/LazyVim
--
-- NOTE: There are some conventions assumed by this configuration:
--              1. The term 'plugin' is reserved for traditional plugins (i.e. VimL/Lua scripts).
--                 See `:help plugin`
--              2. The term 'package' is used for a "complete plugin" written by 3rd party and is
--                 installed either using a plugin/package manager (e.g packer.nvim, or lazy.nvim),
--                 or installed manualy - See `:help package`

---- Leader ------------------------------------------------------------------------------------------------------------
-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '


---- Package Management ------------------------------------------------------------------------------------------------
-- Instal the *lazy.nvim* package manager
-- https://github.com/folke/lazy.nvim
-- See `:help lazy.nvim.txt`
local lazypath = vim.fn.stdpath('data')..'/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({'git', 'clone', '--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable',	-- latest stable release
		lazypath
	})
end
vim.opt.rtp:prepend(lazypath)

-------- Package Installations -------------------------------------------------
--	Packages could be configured using the `config` key.
--	Packages could be also configured after the setup call, as they
--	will be available in your neovim runtime.
require('lazy').setup({

	-- General
	require 'packages.general.telescope',             -- Fuzzy Finder
	require 'packages.general.telescope-fzf-native',  -- Fuzzy Finder
	require 'packages.general.which-key',             -- Keymaps Popup
	-- UI
	require 'packages.ui.dressing',                   -- dressing.nvim
	require 'packages.ui.indent-blankline',           -- Indent Guides
	-- Colors
	require 'packages.ui.colorschemes',               -- Colorschemes
	-- Editor
	require 'packages.editor.vim-stabs',              -- Tabs for Indentations, Spaces for Alignment!
	require 'packages.editor.vim-easy-align',         -- Text Alignment for those of us with OCD
	{ 'numToStr/Comment.nvim', opts = {} },           -- Comments (overides 'gc', and 'gb')
	require 'packages.nvim-cmp',                      -- NeoVim Complete

	-- Code Outline
	require 'packages.code_outline.treesitter',       -- Treesitter
	-- require 'packages.code_outline.symbols-outline',  -- Tag Bar/ Code Outline Pane
	require 'packages.lsp.lspconfig',                   -- LSP Config
	-- -- Manage installation of LSP servers, DAP servers, Linters, and formatters.
	-- require 'packages.lsp.mason',
	-- require 'packages.lsp.mason-lspconfig',

	-- -- Git related plugins
	-- 'tpope/vim-fugitive',
	-- 'tpope/vim-rhubarb',
	--
	-- -- Detect tabstop and shiftwidth automatically
	-- 'tpope/vim-sleuth',

	-- Package Import Directory
	--    For additional information See:
	--     -> `help lazy.nvim-strcuturing-your-plugins`
	--     -> https://github.com/folke/lazy.nvim#-structuring-your-plugins
}, {})

---- Load non-migrated Vim Configuration -------------------------------------------------------------------------------
local vimrc = vim.fn.stdpath('config')..'/vimrc.vim'
vim.cmd.source(vimrc)

---- Mappings ----------------------------------------------------------------------------------------------------------
local mappings = require('mappings')
mappings.load(mappings.general)

---- Options -----------------------------------------------------------------------------------------------------------
-- See `:help vim.o`

---- UI ------------------------------------------------------------------------
-- local theme = 'rose-pine'
vim.o.background='dark'
local theme = 'rose-pine'
if not pcall(vim.cmd.colorscheme, theme) then
	vim.cmd('colorscheme slate')	-- Fallback to a NeoVim bundled coloscheme
end

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

-- vim.o.foldenable = false		-- Disable folding at startup.
-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})

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

