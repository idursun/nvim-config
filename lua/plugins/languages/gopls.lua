return {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
      ["ui.inlayhint.hints"] = {
        assignVariableTypes = true,
        functionTypeParameters = true,
        parameterNames = true,
        constantValues = true,
        rangeVariableTypes = true,
      }
    }
  }
}
