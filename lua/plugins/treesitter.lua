return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  enabled = true,
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      highlight = { enable = true },
      indent = { enable = true },
      sync_install = false,
      auto_install = false,
      ensure_installed = {
        "c",
        "vim",
        "lua",
        "vimdoc",
        "elixir",
        "eex",
        "heex",
        "html",
        "zig",
        "query",
        "markdown",
        "markdown_inline"
      },
    })
  end,
}
