local opt = vim.opt


vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.netrw_keepdir = 0

opt.updatetime = 250

opt.termguicolors = true
opt.signcolumn = "yes"

opt.number = true

opt.cursorline = true
opt.colorcolumn = "100"
opt.scrolloff = 10

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.hlsearch = false
opt.incsearch = true

opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
