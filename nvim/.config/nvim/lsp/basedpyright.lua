return {
    cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/basedpyright-langserver"), "--stdio" },
    filetypes = { "python" },
    root_markers = { ".git", "pyproject.toml", "setup.py" },
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
	settings = {
		basedpyright = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "openFilesOnly",
			},
		},
		python = {
			pythonPath = vim.fn.exepath("python"),
		},
	},
}
