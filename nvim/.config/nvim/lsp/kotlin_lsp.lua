return {
    cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/intellij-server"), "--stdio" },
    filetypes = { "kotlin" },
    root_markers = { "build.gradle", "settings.gradle", "build.gradle.kts", ".git" },
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    settings = { },
}
