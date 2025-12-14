return {
	"neovim/nvim-lspconfig",
	lazy = false,
	priority = 100,
	dependencies = { "williamboman/mason.nvim" },
	keys = {
		{ "<leader>ld", vim.lsp.buf.definition,  desc = "Go to definition" },
		{ "<leader>lk", vim.lsp.buf.hover,       desc = "Show hover info" },
		{ "<leader>lr", vim.lsp.buf.rename,      desc = "Rename symbol" },
		{ "<leader>la", vim.lsp.buf.code_action, desc = "Code action" },
	},
	config = function()
		-- Server configs go here:
		local servers = {
			ca65 = {
				filetypes = { "s", "asm" },
				root_markers = { ".git" },
				cmd_override = { "ca65-lsp" },
			},
			yamlls = {
				pkg = "yaml-language-server",
				filetypes = { "yaml", "yml" },
				root_markers = { ".git" },
				flags = { "--stdio" },
			},
			roslyn = {
				pkg = "roslyn",
				filetypes = { "cs" },
				root_markers = { "Assets", "ProjectSettings", "Packages", "*.csproj", ".git" },
				flags = { "--logLevel", "none", "--extensionLogDirectory", vim.fn.stdpath("state") .. "/roslyn", "--stdio" },
				settings = {
					["csharp|code_lens"] = {
						dotnet_enable_references_code_lens = true,
					},
				},
			},
			clangd = {
				pkg = "clangd",
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "h", "hpp" },
				root_markers = { "compile_commands.json", ".git" },
				flags = { "--background-index", "--clang-tidy" },
			},
			cmake = {
				pkg = "neocmakelsp",
				filetypes = { "cmake" },
				root_markers = { "CMakeLists.txt", ".git" },
				flags = { "stdio" },
			},
			pyright = {
				pkg = "pyright",
				filetypes = { "python" },
				root_markers = { ".git", "pyproject.toml", "setup.py" },
			},
			tsserver = {
				pkg = "typescript-language-server",
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
				root_markers = { "package.json", "tsconfig.json", ".git" },
				flags = { "--stdio" },
			},
			lua_ls = {
				pkg = "lua-language-server",
				filetypes = { "lua" },
				root_markers = { ".git" },
				settings = {
					Lua = { diagnostics = { globals = { "vim" } } },
				},
			},
		}

		for name, cfg in pairs(servers) do
			vim.api.nvim_create_autocmd("FileType", {
				pattern = cfg.filetypes,
				callback = function()
					local registry = require("mason-registry")
					local mason_path = require("mason.settings").current.install_root_dir

					local function start_lsp()
						local cmd
						if cfg.cmd_override ~= nil then
							cmd = cfg.cmd_override
						else
							local bin = mason_path .. "/bin/" .. cfg.pkg
							if vim.fn.executable(bin) == 0 then
								vim.notify(
									"LSP binary for " .. cfg.pkg .. " not found at " .. bin ..
									"\nTry running :Mason and installing it manually.",
									vim.log.levels.WARN
								)
								return
							end
							cmd = { bin }
						end
						if cfg.flags then
							for _, v in ipairs(cfg.flags) do
								table.insert(cmd, v)
							end
						end

						vim.lsp.start(vim.tbl_extend("force", cfg, {
							name = name,
							cmd = cmd,
							settings = cfg.settings,
							root_dir = vim.fs.root(0, cfg.root_markers),
						}))

						vim.notify("Started LSP: " .. name, vim.log.levels.INFO)
					end

					-- Get or install package
					local pkg = cfg.cmd_override or registry.get_package(cfg.pkg)
					if cfg.cmd_override == nil and not pkg:is_installed() then
						vim.notify("Installing missing LSP: " .. cfg.pkg .. " ...", vim.log.levels.INFO)
						pkg:install()

						-- Wait for install to complete
						pkg:on("install:success", function()
							vim.schedule(function()
								vim.notify("LSP installed: " .. cfg.pkg, vim.log.levels.INFO)
								start_lsp()
							end)
						end)
					else
						start_lsp()
					end
				end,
			})
		end
	end,
}
