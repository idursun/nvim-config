return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = true,
  lazy = true,
  keys = {
    { "<leader>tt", ":ToggleTerm<CR>", silent = true },
    { "<leader>ts", ":ToggleTermSendVisualLines<CR>", silent = true, mode = "v" },
  },
}

