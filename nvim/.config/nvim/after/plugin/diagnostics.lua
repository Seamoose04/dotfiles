-- state to remember the last diagnostic line and its window
local last_diag_line = nil
local last_diag_win = nil

-- Function to close the diagnostic float
local function close_diag_float()
	if last_diag_win and vim.api.nvim_win_is_valid(last_diag_win) then
		local buf = vim.api.nvim_win_get_buf(last_diag_win)
		local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
		if ft == "vim_diagnostic" then
			pcall(vim.api.nvim_win_close, last_diag_win, true)
		end
	end
	last_diag_line = nil
	last_diag_win = nil
end

-- When the cursor moves, show or close diagnostics
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
	callback = function()
		local bufnr = 0
		local line = vim.fn.line(".") - 1

		-- If we moved off the last diagnostic line, close its popup
		if last_diag_line and line ~= last_diag_line then
			close_diag_float()
		end

		-- Check if current line has diagnostics
		local diags = vim.diagnostic.get(bufnr, { lnum = line })
		local has_issue = false
		for _, d in ipairs(diags) do
			if d.severity == vim.diagnostic.severity.ERROR
				or d.severity == vim.diagnostic.severity.WARN then
				has_issue = true
				break
			end
		end

		if has_issue then
			-- Open diagnostic float and remember its window
			local win = vim.diagnostic.open_float(nil, {
				focus = false,
				scope = "line",
				border = "rounded",
				source = "always",
				severity_sort = true,
			})
			-- `open_float` returns nothing, but creates exactly one float
			-- find it by filetype
			for _, w in ipairs(vim.api.nvim_list_wins()) do
				local cfg = vim.api.nvim_win_get_config(w)
				if cfg.relative ~= "" then
					local b = vim.api.nvim_win_get_buf(w)
					local ft = vim.api.nvim_get_option_value("filetype", { buf = b })
					if ft == "vim_diagnostic" then
						last_diag_win = w
						break
					end
				end
			end
			last_diag_line = line
		end
	end,
})

