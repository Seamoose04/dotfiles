-- Set leader before anything else
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim
require("config.lazy")

-- UI tweaks
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt["tabstop"] = 4
vim.opt["shiftwidth"] = 4

-- Keep cursor centered
vim.opt.scrolloff = 8
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true }) -- Half-page down + recenter
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true }) -- Half-page up + recenter

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Colorscheme
vim.cmd.colorscheme("tokyonight")
