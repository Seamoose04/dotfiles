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

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Colorscheme
vim.cmd.colorscheme("tokyonight")
