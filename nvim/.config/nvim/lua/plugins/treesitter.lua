return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	lazy = false,
	config = function()
		require("nvim-treesitter").setup({
			highlight = {
				enable = true, -- better syntax highlighting
			},
			indent = {
				enable = true, -- smarter indentation
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",       -- start selection
					node_incremental = "<CR>",     -- expand to next node
					scope_incremental = "<S-CR>",  -- expand to scope
					node_decremental = "<BS>",     -- shrink
				},
			},
		})
		require("nvim-treesitter").install({
			"lua", "python", "javascript", "typescript", "c", "cpp", "bash", "json", "yaml", "html", "css", "asm"
		})
	end,
}

