return {
    "hrsh7th/cmp-nvim-lsp",
    lazy = false,
    dependencies = {
        "williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
    },
    keys = {
        { "<leader>ld", vim.lsp.buf.definition,  desc = "Go to definition" },
        { "<leader>lk", vim.lsp.buf.hover,       desc = "Show hover info" },
        { "<leader>lr", vim.lsp.buf.rename,      desc = "Rename symbol" },
        { "<leader>la", vim.lsp.buf.code_action, desc = "Code action" },
    },
    config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"basedpyright",
				"clangd",
				"lua_ls",
			},
			automatic_installation = true,
		})
        -- Manually load lsp/ configs
        local lsp_dir = vim.fn.stdpath("config") .. "/lsp"
        for _, file in ipairs(vim.fn.glob(lsp_dir .. "/*.lua", false, true)) do
            local name = vim.fn.fnamemodify(file, ":t:r")
            local ok, cfg = pcall(dofile, file)
            if ok then
                vim.lsp.config(name, cfg)
            end
        end

        vim.lsp.enable({
            "basedpyright",
            "clangd",
            "lua_ls",
            "ca65",
            "ppl",
        })
    end,
}
