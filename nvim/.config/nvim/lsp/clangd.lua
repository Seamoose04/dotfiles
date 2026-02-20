return {
    cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/clangd"), "--background-index", "--clang-tidy" },
    filetypes = { "c", "cpp", "h", "hpp" },
    root_markers = { "compile_commands.json", ".git" },
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
}
