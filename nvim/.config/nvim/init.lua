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
vim.opt.scrolloff = 12
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true }) -- Half-page down + recenter
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true }) -- Half-page up + recenter

-- Move selections with ctrl
-- vim.keymap.set("v", "<C-k>", "d2kp'[V']=gv", { noremap = true, silent = true }) -- Selection Up
-- vim.keymap.set("v", "<C-j>", "dp'[V']=gv", { noremap = true, silent = true }) -- Selection Down
vim.keymap.set("n", "<C-k>", "dd2kp==", { noremap = true, silent = true }) -- Line Up
vim.keymap.set("n", "<C-j>", "ddp==", { noremap = true, silent = true }) -- Line Down
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>'[V']=gv", { noremap = true, silent = true }) -- Selection Up
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>'[V']=gv", { noremap = true, silent = true }) -- Selection Down

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Colorscheme
vim.cmd.colorscheme("tokyonight")
