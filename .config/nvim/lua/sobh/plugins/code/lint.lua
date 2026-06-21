-- Package:	nvim-lint
-- Description:	Asynchronous linter.
-- URL:		https://github.com/mfussenegger/nvim-lint

return {
	'mfussenegger/nvim-lint',
	event = 'BufReadPost',
	config = function()
		local lint = require('lint')
		lint.linters_by_ft = {
			markdown = { 'cspell' },
			typescript = { 'cspell' },
			javascript = { 'cspell' },
			typescriptreact = { 'cspell' },
			javascriptreact = { 'cspell' },
			lua = { 'cspell' },
			python = { 'cspell' },
		}
		vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost', 'InsertLeave' }, {
			callback = function()
				if vim.fn.executable('cspell') == 1 then
					lint.try_lint()
				end
			end,
		})

		-- Add word under cursor to cspell config
		vim.api.nvim_create_user_command('CSpellAdd', function()
			local word = vim.fn.expand('<cword>')
			local candidates = { 'cspell.json', '.cspell.json', 'cspell.yaml', '.cspell.yaml', 'cspell.config.yaml' }
			local cspell_path = ''
			for _, name in ipairs(candidates) do
				cspell_path = vim.fn.findfile(name, '.;')
				if cspell_path ~= '' then break end
			end
			if cspell_path == '' then
				vim.notify('No cspell config found', vim.log.levels.WARN)
				return
			end
			local content = vim.fn.readfile(cspell_path)
			local json = vim.fn.json_decode(table.concat(content, '\n'))
			json.words = json.words or {}
			if not vim.tbl_contains(json.words, word) then
				table.insert(json.words, word)
				table.sort(json.words)
			end
			vim.fn.writefile(vim.split(vim.fn.json_encode(json), '\n'), cspell_path)
			vim.notify('"' .. word .. '" added to ' .. vim.fn.fnamemodify(cspell_path, ':t'))
			lint.try_lint()
		end, { desc = 'Add word to cspell dictionary' })
	end,
}
