return {
  cmd = { "gopls" },
  root_markers = { ".git", "go.mod", "go.work" },
  filetypes = { "go", "gotempt", "gowork", "gomod" },
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
        ["vi.inlayhint.hints"] = {
          compositeLiteralFields = true,
          constantValues = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },
  },
}
