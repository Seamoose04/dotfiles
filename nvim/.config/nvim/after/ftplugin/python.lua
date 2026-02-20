local function find_venv(start_path)
	local path = start_path
	local venv_names = { ".venv", "venv" }
	local root_markers = { ".git", "pyproject.toml", "setup.py" }

	while path ~= "/" do
		for _, name in ipairs(venv_names) do
			local venv_python = path .. "/" .. name .. "/bin/python"
			if vim.fn.filereadable(venv_python) == 1 then
				return venv_python
			end
		end

		for _, marker in ipairs(root_markers) do
			if vim.fn.filereadable(path .. "/" .. marker) == 1
				or vim.fn.isdirectory(path .. "/" .. marker) == 1 then
				return nil
			end
		end

		path = vim.fn.fnamemodify(path, ":h")
	end
	return nil
end

local venv_python = find_venv(vim.fn.expand("%:p:h"))
if venv_python then
	local active_python = vim.fn.exepath("python")
	local real_venv = vim.fn.resolve(venv_python)
	local real_active = vim.fn.resolve(active_python)

	if real_venv ~= real_active then
		vim.notify(
			"venv found at " .. venv_python .. " but not activated. Run: source " ..
			vim.fn.fnamemodify(venv_python, ":h:h") .. "/bin/activate",
			vim.log.levels.WARN
		)
	end
end
