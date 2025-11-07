return {
	dir = vim.fn.stdpath("config") .. "/lua/plugins",
	name = "c-switch",
	event = { "BufReadPre *.c", "BufReadPre *.cpp", "BufReadPre *.h", "BufReadPre *.hpp" },
	dependencies = { "nvim-telescope/telescope.nvim" },

	config = function()
		local pickers = require("telescope.pickers")
		local finders = require("telescope.finders")
		local conf = require("telescope.config").values
		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")

		local function switch_cpp_pair()
			local filepath = vim.api.nvim_buf_get_name(0)
			if filepath == "" then return end

			local dir = vim.fn.fnamemodify(filepath, ":h")
			local name = vim.fn.fnamemodify(filepath, ":t:r")
			local ext = vim.fn.fnamemodify(filepath, ":e")

			local headers = { "h", "hpp", "hh" }
			local sources = { "cpp", "cc", "c" }

			local target_exts = vim.tbl_contains(headers, ext) and sources or headers
			local matches = {}

			for _, target_ext in ipairs(target_exts) do
				local alt = dir .. "/" .. name .. "." .. target_ext
				if vim.fn.filereadable(alt) == 1 then
					table.insert(matches, alt)
				end
			end

			if #matches == 0 then
				return -- fail silently
			elseif #matches == 1 then
				vim.cmd("edit " .. vim.fn.fnameescape(matches[1]))
			else
				pickers
					.new({}, {
						prompt_title = "Select file to open",
						finder = finders.new_table({ results = matches }),
						sorter = conf.generic_sorter({}),
						initial_mode = "normal", -- 👈 open Telescope in NORMAL mode
						attach_mappings = function(prompt_bufnr, _)
							actions.select_default:replace(function()
								actions.close(prompt_bufnr)
								local selection = action_state.get_selected_entry()
								if selection then
									vim.cmd("edit " .. vim.fn.fnameescape(selection[1]))
								end
							end)
							return true
						end,
					})
					:find()
			end
		end

		local function setup_key(bufnr)
			vim.keymap.set("n", "<leader>fc", switch_cpp_pair, {
				buffer = bufnr,
				silent = true,
				noremap = true,
				desc = "Toggle header/source",
			})
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if client and client.name == "clangd" then
					setup_key(args.buf)
				end
			end,
		})
	end,
}

