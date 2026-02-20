return {
    cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/lua-language-server") },
    filetypes = { "lua" },
    root_markers = { ".git" },
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    settings = {
        Lua = { diagnostics = { globals = { "vim" } } },
    },
}
