return {
	cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/typescript-language-server"), "--stdio" },
	filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	settings = {
		typescript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayReturnTypeHints = true,
			},
		},
		javascript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayReturnTypeHints = true,
			},
		},
	},
}
