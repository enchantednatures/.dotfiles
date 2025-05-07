return {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python", "py" },
  root_markers = { ".git", ".venv", "requirements.txt" },
  enabled = true,
  single_file_support = true,
  settings = {
    disableOrganizeImports = true,
    basedpyright = {
      analysis = {
        -- ignore = { "*" },
        typeCheckingMode = "standard",
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
      },
    },
  },
}
