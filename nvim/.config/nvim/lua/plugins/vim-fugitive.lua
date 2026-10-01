return {
	"tpope/vim-fugitive",
	cmd = { "Git", "G" },
	keys = {
		{ "<leader>gg", "<cmd>Git<cr>", desc = "Git status" },
		{ "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
		{ "<leader>gp", "<cmd>Git push<cr>", desc = "Git push" },
		{ "<leader>gu", "<cmd>Git pull<cr>", desc = "Git pull" },
		{
			"<leader>gi",
			function()
				vim.fn.system("git init")
				vim.notify("Initialized new git repository", vim.log.levels.INFO)
			end,
			desc = "Git init"
		},
		{
			"<leader>gb",
			function()
				vim.ui.input({ prompt = "Branch name: " }, function(branch)
					if not branch or branch == "" then
						return
					end
					vim.cmd("Git checkout -b " .. branch .. " || Git checkout " .. branch)
				end)
			end,
			desc = "Git checkout/create branch"
		}
	}
}
