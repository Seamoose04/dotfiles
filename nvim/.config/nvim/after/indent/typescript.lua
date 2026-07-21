-- ~/.config/nvim/after/indent/typescript.lua
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
