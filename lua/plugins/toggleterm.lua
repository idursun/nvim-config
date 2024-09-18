return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = true,
  lazy = true,
  keys = {
    { "<leader>tt", ":ToggleTerm size=40 direction=float <CR>", silent = true },
    { "<leader>tn", ":ToggleTerm<CR>", silent = true },
    { "<leader>ts", ":ToggleTermSendVisualLines<CR>", silent = true, mode = "v" },
    { "<leader>jl", ":TermExec cmd=\"jj log\" size=40 direction=float <CR>", silent = true },
    { "<leader>jd", ":TermExec cmd=\"jj diff\" size=40 direction=float <CR>", silent = true },
  },
}

