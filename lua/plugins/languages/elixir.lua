return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require('lspconfig')

    local configs = require("lspconfig.configs")

    if not configs.lexical then
      local lexical_config = {
        filetypes = { "elixir", "eelixir", "heex" },
        cmd = { "/Users/idursun/repositories/elixir/lexical/_build/dev/package/lexical/bin/start_lexical.sh" },
        settings = {},
      }
      configs.lexical = {
        default_config = {
          filetypes = lexical_config.filetypes,
          cmd = lexical_config.cmd,
          root_dir = function(fname)
            return lspconfig.util.root_pattern("mix.exs", ".git")(fname) or vim.loop.os_homedir()
          end,
          -- optional settings
          settings = lexical_config.settings,
        },
      }
    end

    lspconfig.lexical.setup({})
  end
}
