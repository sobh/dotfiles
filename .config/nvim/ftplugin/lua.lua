vim.keymap.set({'i', 'n'}, '<F2>', '<cmd>w<CR> <cmd>!lua %:p<CR>', { desc = 'Execute Current File' })
