return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = true,
  lazy = true,
  keys = {
    { "<leader>tt", ":ToggleTerm<CR>", silent = true },
    { "<leader>T", ":ToggleTerm size=40 direction=float <CR>", silent = true },
    { "<leader>tjl", ":TermExec cmd=\"jj log\" size=40 direction=float <CR>", silent = true },
    { "<leader>tjd", ":TermExec cmd=\"jj diff\" size=40 direction=float <CR>", silent = true },
    { "<leader>ts", ":ToggleTermSendVisualLines<CR>", silent = true, mode = "v" },
  },
}

