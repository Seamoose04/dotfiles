return {
    cmd = {
		vim.fn.expand("~/.local/share/nvim/mason/bin/clangd"),
		"--background-index",
		"--query-driver=" .. vim.fn.expand("~/.espressif/tools/xtensa-esp-elf/esp-13.2.0_20240530/bin/xtensa-esp32s3-elf-gcc")
	},
    filetypes = { "c", "cpp" },
    root_markers = { ".clangd", "compile_commands.json", ".git" },
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
}
