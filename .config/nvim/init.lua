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

	-- UI ------------------------------------------------------------------
	require('sobh.plugins.ui.colorschemes'),           -- Colorschemes
	require('sobh.plugins.ui.dressing'),               -- UI for vim.ui.input/select
	require('sobh.plugins.ui.snacks'),                 -- UI (notifications, words, lazygit)
	require('sobh.plugins.ui.outline'),                -- Code Outline Sidebar
	-- require('sobh.plugins.ui.indent-rainbowline'),     -- Rainbow Indent Guides
	-- require('sobh.plugins.ui.indent-blankline'),    -- Indent Guides (plain)
	require('sobh.plugins.ui.blink-indent'),        -- Indent Guides (performant)
	require('sobh.plugins.ui.nvim-highlight-colors'),   -- Highlight Color Codes
	-- require('sobh.plugins.ui.ccc'),                 -- Color Picker
	-- require('sobh.plugins.ui.colorizer'),           -- Colorizer
	-- require('sobh.plugins.ui.colortils'),           -- Color Utils
	-- File Tree Explorers
	require('sobh.plugins.ui.neo-tree'),               -- File Explorer (sidebar)
	-- require('sobh.plugins.ui.snacks-explorer'),     -- File Explorer (snacks)
	-- require('sobh.plugins.ui.nvim-tree'),           -- File Explorer (nvim-tree)

	-- General (pick one fuzzy finder)
	-- require('sobh.plugins.general.telescope'),            -- Fuzzy Finder (Telescope)
	-- require('sobh.plugins.general.telescope-fzf-native'), -- Fuzzy Finder (Native)
	require('sobh.plugins.general.fzf-lua'),           -- Fuzzy Finder (fzf-lua, faster)
	require('sobh.plugins.general.which-key'),            -- Keymaps Popup
	-- require('sobh.plugins.general.tmux'),             -- tmux Navigation

	-- VCS
	require('sobh.plugins.vcs.gitsigns'),              -- Git Integration
	require('sobh.plugins.vcs.diffview'),              -- Diff & File History Viewer
	require('sobh.plugins.vcs.fugitive'),              -- Git Blame & Commands

	-- Editor
	require('sobh.plugins.editor.vim-stabs'),          -- Tabs for Indentation, Spaces for Alignment
	require('sobh.plugins.editor.vim-easy-align'),     -- Text Alignment
	require('sobh.plugins.editor.grug-far'),           -- Search and Replace
	{ 'numToStr/Comment.nvim', opts = {} },            -- Comments (gc, gb)
	{ 'echasnovski/mini.ai', opts = {} },              -- Better text objects (around/inside)
	require('sobh.plugins.editor.nvim-cmp'),           -- Completion

	-- AI (use one at a time)
	require('sobh.plugins.ai.avante'),
	-- require('sobh.plugins.ai.agentic'),
	-- require('sobh.plugins.ai.codecompanion'),

	-- Code
	require('sobh.plugins.code.formatter'),            -- Code Formatter
	require('sobh.plugins.code.lint'),                 -- Linter (cspell)
	require('sobh.plugins.code.treesitter'),           -- Treesitter
	require('sobh.plugins.code.lsp'),                  -- LSP

}, {})

---- UI ----------------------------------------------------------------------------------------------------------------
require('sobh').set_background()
local theme = 'caironoon'
if not pcall(vim.cmd.colorscheme, theme) then
	vim.cmd.colorscheme('habamax')	-- Fallback to a NeoVim bundled coloscheme
end

---- Mappings ----------------------------------------------------------------------------------------------------------
require('sobh.mappings').setup()

---- Options -----------------------------------------------------------------------------------------------------------
require('sobh.config.options').setup()

---- LSP & Diagnostics -------------------------------------------------------------------------------------------------
require('sobh.config.lsp').setup()

---- Autocommands ------------------------------------------------------------------------------------------------------
require('sobh.config.autocmds').setup()
