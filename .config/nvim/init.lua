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

-------- Package Installations -----------------------------------------------------------------------------------------
--	Packages could be configured using the `config` key.
--	Packages could be also configured after the setup call, as they
--	will be available in your neovim runtime.
require('lazy').setup({
	-- Package Import Directory
	--    For additional information See:
	--     -> `help lazy.nvim-strcuturing-your-plugins`
	--     -> https://github.com/folke/lazy.nvim#-structuring-your-plugins
	{ import = 'packages' },
}, {})

---- Load non-migrated Vim Configuration -------------------------------------------------------------------------------
local vimrc = vim.fn.stdpath('config')..'/vimrc.vim'
vim.cmd.source(vimrc)

---- Options -----------------------------------------------------------------------------------------------------------
vim.cmd('colorscheme rose-pine')
-- Tabs
vim.o.tabstop = 8	-- Number of spaces of the <Tab>
vim.o.shiftwidth = 8	-- Number of spaces for indents ('cinednt', '<<', '>>')
vim.o.expandtab	= false	-- Do not expands <Tab> into spaces
vim.o.softtabstop = 8	-- Number of space of <Tab> while editing

--
vim.o.wrap = false
vim.o.textwidth = 80
vim.o.colorcolumn = '+1,+21,+41'
vim.o.number = true		-- Enable Line Numbers
vim.o.incsearch = true
---- Keymaps -----------------------------------------------------------------------------------------------------------
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)		-- Open NetRW

-- Save, and Run Script
vim.keymap.set('n', '<F2>', ':w<CR>:!clear; %:p<CR>')
vim.keymap.set('i', '<F2>', '<Esc>:w<CR>:!clear; %:p<CR>')

-- NERDTree
vim.keymap.set('n', '<F11>', ':NERDTreeToggle<CR>')
vim.keymap.set('i', '<F11>', '<Esc>:NERDTreeToggle<CR>')
-- Taglist
vim.keymap.set('n', '<F12>', ':TagbarToggle<CR>')
vim.keymap.set('i', '<F12>', '<Esc>:TagbarToggle<CR>')

-- Substitute word under cursor
-- vim.keymap.set('n', '<leader>s', ':%s/\<<C-r><C-w>\>/')

-- Switch between recent buffers with Shift+Tab
vim.keymap.set('n', '<S-Tab>', ':b#<CR>')

-- Edit and resouce $HOME/.vimrc
vim.keymap.set('n', '<leader>ev', ':vsplit $MYVIMRC<CR>')
vim.keymap.set('n', '<leader>sv', ':source $MYVIMRC<CR>')

-- Faster Insert -> Normal Transitions
vim.keymap.set('i', 'jk', '<esc>')
vim.keymap.set('i', 'jj', '<esc>')
