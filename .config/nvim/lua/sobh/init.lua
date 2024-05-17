local M = {}

-- Set the 'backgroun' according to the system mode
function M.set_background()
	if vim.fn.has('unix') then
		local mode = vim.fn.system({ 'gsettings', 'get', 'org.gnome.desktop.interface', 'color-scheme' })
		if string.find(mode, 'dark') then
			vim.opt.background = 'dark'
		else
			vim.opt.background = 'light'
		end
	end
end

return M
