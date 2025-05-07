return {
  cmd = { "clangd" },
  root_markers = { ".clangd", "compile_commands.json" },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  capabilities = {
    offsetEncoding = { "utf-8", "utf-16" },
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
  },
}
