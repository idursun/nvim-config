return {
  "neovim/nvim-lspconfig",
  config = function()
      local lspconfig = require('lspconfig')
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      lspconfig.gopls.setup({
        capabilities = capabilities,
        settings = {
          gopls = {
            ["ui.inlayhint.hints"] = {
              assignVariableTypes = true,
              functionTypeParameters = true,
              parameterNames = true,
              constantValues = true,
              rangeVariableTypes = true,
            }
          }
        }
      })
  end,
}
