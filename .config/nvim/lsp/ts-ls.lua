local lspconfig = require "lspconfig"

return {
  cmd = { "typescript-language-server", "--stdio" },
  root_dir = lspconfig.util.root_pattern "package.json",
  single_file_support = false,
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  root_markers = {
    "tsconfig.json",
    "jsconfig.json",
    "package.json",
    ".git",
  },
}
