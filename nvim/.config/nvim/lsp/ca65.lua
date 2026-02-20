return {
    cmd = { "ca65-lsp" },
    filetypes = { "asm" },
    root_markers = { ".git", "Makefile" },
    settings = { ca65 = { includePaths = { "include" } } },
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
}
