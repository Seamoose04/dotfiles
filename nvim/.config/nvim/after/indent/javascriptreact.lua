-- ~/.config/nvim/after/indent/javascriptreact.lua
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
