-- ============================================================================
-- Module: lsp.lua
-- Description: Core LSP configuration (server enablement, inlay hints)
-- Dependencies: None (uses built-in LSP)
-- ============================================================================

vim.lsp.log.set_level "ERROR"

vim.lsp.config("*", {
  root_markers = { ".git" },
})

vim.g.markdown_fenced_languages = {
  "ts=typescript",
}

vim.lsp.enable {
  "basedpyright",
  "bashls",
  "buf_ls",
  "clangd",
  "dockerls",
  "dockerfile-language-server",
  "docker_compose_language_service",
  "denols",
  "graphql",
  "jsonls",
  "lua_ls",
  "ruff",
  "terraform-ls",
  "yamlls",
}

-- Enable inlay hints on LSP attach
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function() vim.lsp.inlay_hint.enable() end,
})
