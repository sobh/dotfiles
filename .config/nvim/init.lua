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

---- UI ------------------------------------------------------------------------
-- local theme = 'rose-pine'
vim.opt.background='light'
local theme = 'caironoon'
if not pcall(vim.cmd.colorscheme, theme) then
	vim.cmd('colorscheme slate')	-- Fallback to a NeoVim bundled coloscheme
end

---- Load non-migrated Vim Configuration -------------------------------------------------------------------------------
local vimrc = vim.fn.stdpath('config')..'/vimrc.vim'
vim.cmd.source(vimrc)

---- Mappings ----------------------------------------------------------------------------------------------------------
local mappings = require('mappings')
mappings.load(mappings.general)

---- Autocommands ------------------------------------------------------------------------------------------------------

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

---- Options -----------------------------------------------------------------------------------------------------------
require('config.options')
