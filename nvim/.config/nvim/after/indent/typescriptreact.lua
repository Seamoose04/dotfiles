-- ~/.config/nvim/after/indent/typescriptreact.lua
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
