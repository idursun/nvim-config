local lspconfig = require('lspconfig')
return {
  init_options = {
    userLanguages = {
      elixir = "html-eex",
      eelixir = "html-eex",
      heex = "html-eex",
    }
  },
  root_dir = lspconfig.util.root_pattern("assets", "tailwind.config.js", ".git"),
}
