return {
  cmd = { "spectral-language-server", "--stdio" },
  filetypes = { "yaml", "json", "yml" },
  root_markers = { ".git", ".spectral.yaml", ".spectral.yml", ".spectral.json", ".spectral.js" },
  single_file_support = true,
  settings = {
    enable = false,
    run = "onType",
    validateLanguages = { "yaml", "json", "yml" },
  },
}
