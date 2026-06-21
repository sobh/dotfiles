--- Global autocommands.
---@module "sobh.config.autocmds"

local M = {}

M.setup = function()
	-- Highlight text on yank
	local yank_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
	vim.api.nvim_create_autocmd('TextYankPost', {
		group = yank_group,
		callback = function()
			vim.highlight.on_yank()
		end,
	})

	-- Strip trailing whitespace on save
	local whitespace_group = vim.api.nvim_create_augroup('StripWhitespace', { clear = true })
	vim.api.nvim_create_autocmd('BufWritePre', {
		group = whitespace_group,
		callback = function()
			if vim.bo.filetype == 'tsv' then return end
			local pos = vim.api.nvim_win_get_cursor(0)
			vim.cmd([[%s/\s\+$//e]])
			vim.api.nvim_win_set_cursor(0, pos)
		end,
	})

	-- Enable spell checking for prose filetypes
	local spell_group = vim.api.nvim_create_augroup('SpellCheck', { clear = true })
	vim.api.nvim_create_autocmd('FileType', {
		group = spell_group,
		pattern = { 'markdown', 'gitcommit', 'text' },
		callback = function()
			vim.opt_local.spell = true
		end,
	})
end

return M
