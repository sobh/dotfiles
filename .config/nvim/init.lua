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

	-- UI
	require 'sobh.plugins.ui.colorschemes',           -- Colorschemes
	require 'sobh.plugins.ui.dressing',               -- dressing.nvim
	require 'sobh.plugins.ui.indent-blankline',       -- Indent Guides
	require 'sobh.plugins.ui.nvim-highlight-colors',  -- Highlight Color Codes
	require 'sobh.plugins.ui.outline',                -- Code Outline Sidebar
	-- require 'sobh.plugins.ui.neo-tree',               -- File System Explorer
	-- require 'sobh.plugins.ui.ccc',                   -- Ok
	-- require 'sobh.plugins.ui.colorizer',        -- Ok
	-- require 'sobh.plugins.ui.colortils',
	-- require 'sobh.plugins.ui.vim-css-color',

	-- General
	require 'sobh.plugins.general.telescope',            -- Fuzzy Finder
	require 'sobh.plugins.general.telescope-fzf-native', -- Fuzzy Finder (Native)
	require 'sobh.plugins.general.which-key',            -- Keymaps Popup
	require 'sobh.plugins.general.gitsigns',             -- Git Integration
	require 'sobh.plugins.general.tmux',                 -- tmux Navigation

	-- Editor
	require 'sobh.plugins.editor.vim-stabs',          -- Tabs for Indentations, Spaces for Alignment!
	require 'sobh.plugins.editor.vim-easy-align',     -- Text Alignment for those of us with OCD
	{ 'numToStr/Comment.nvim', opts = {} },           -- Comments (overides 'gc', and 'gb')
	require 'sobh.plugins.editor.nvim-cmp',           -- NeoVim Complete

	-- Syntax
	require 'sobh.plugins.syntax.treesitter',         -- Treesitter
	require 'sobh.plugins.syntax.lspconfig',          -- LSP Config
	-- -- Manage installation of LSP servers, DAP servers, Linters, and formatters.
	-- require 'sobh.plugins.lsp.mason',
	-- require 'sobh.plugins.lsp.mason-lspconfig',

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
require('sobh.mappings').setup()

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
require('sobh.config.options').setup()

function Xretab(ts)
	local levels = 8
	if ts == nil then
		ts = 4
	end
	for i = levels, 1, -1 do
		local spaces = string.rep(' ', ts*i)
		local tabs   = string.rep('\t', i)
		local command = '%s/^'..spaces..'/'..tabs..'/'
		vim.cmd(command)
	end
end
