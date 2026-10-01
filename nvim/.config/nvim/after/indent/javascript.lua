-- ~/.config/nvim/after/indent/javascript.lua
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
