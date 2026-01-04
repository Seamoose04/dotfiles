return {
  {
    "nvim-lua/plenary.nvim", -- (or any plugin entry)
    config = function()
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
          pattern = "*.inc",
          callback = function()
              vim.bo.filetype = "asm"
          end,
      })
    end
  }
}
