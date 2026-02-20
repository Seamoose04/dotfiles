return {
  "mbbill/undotree",
  config = function()
    vim.opt.undofile = true  -- persistent undo across sessions
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" })
  end,
}
