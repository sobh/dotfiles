-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- Faster Insert -> Normal Transitions
vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("i", "jj", "<esc>")

-- Faster Command Mode
vim.keymap.set({ "n", "v" }, ":", ";", { noremap = true })
vim.keymap.set({ "n", "v" }, ";", ":", { noremap = true })
vim.keymap.set("n", "q;", "q:", { noremap = true })
