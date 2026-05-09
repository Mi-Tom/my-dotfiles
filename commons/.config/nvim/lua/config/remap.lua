vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { noremap = true })
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })
