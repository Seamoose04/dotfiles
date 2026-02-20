return {
    cmd = { "python3", "/home/seamus/src/hpprime-lsp/src/server.py" },
    filetypes = { "txt", "hpprgm" },
    root_markers = { ".git" },
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
}
