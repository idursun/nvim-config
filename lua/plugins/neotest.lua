
return {
  "nvim-neotest/neotest",
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'leoluz/nvim-dap-go',
    'fredrikaverpil/neotest-golang',
    'jfpedroza/neotest-elixir',
  },
  keys = {
    {
      "<leader>t",
      function()
        require("neotest").run.run({ suite = false })
      end,
      desc = "Debug nearest test",
    }
  },
  config = function ()
    require("neotest").setup({
      adapters = {
        require("neotest-golang"),
        require("neotest-elixir"),
      }
    })
  end
}
