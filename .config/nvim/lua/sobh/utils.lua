--- Utility functions.
---@module "sobh.utils"

local M = {}

--- Check if running in a dumb terminal (linux TTY).
---@return boolean
function M.is_tty()
	return vim.env.TERM == 'linux' or vim.env.TERM == 'dumb'
end

--- Set vim 'background' based on the system color scheme.
function M.set_background()
	if vim.fn.has('unix') == 1 then
		local mode = vim.fn.system({ 'gsettings', 'get', 'org.gnome.desktop.interface', 'color-scheme' })
		if string.find(mode, 'dark') then
			vim.opt.background = 'dark'
		else
			vim.opt.background = 'light'
		end
	end
end

--- Custom fold text: first line + line count indicator.
function M.foldtext()
	local line = vim.fn.getline(vim.v.foldstart)
	local count = vim.v.foldend - vim.v.foldstart
	return line .. ' ⋯ ' .. count .. ' lines'
end

--- Convert space-indented file to tab indentation.
---@param ts? integer Tab size (default 4)
function M.retab(ts)
	ts = ts or 4
	for i = 8, 1, -1 do
		local spaces = string.rep(' ', ts * i)
		local tabs = string.rep('\t', i)
		vim.cmd('%s/^' .. spaces .. '/' .. tabs .. '/')
	end
end

return M
