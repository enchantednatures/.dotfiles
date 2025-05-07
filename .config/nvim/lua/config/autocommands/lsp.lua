local augroups = require "config.autocommands.augroups"

local function lsp_highlight(client, bufnr)
  if client.supports_method "textDocument/documentHighlight" then
    vim.api.nvim_create_augroup("lsp_document_highlight", {
      clear = false,
    })
    vim.api.nvim_clear_autocmds {
      buffer = bufnr,
      group = "lsp_document_highlight",
    }
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroups.lspFeatures,
  callback = function(args)
    if not (args.data and args.data.client_id) then return end
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf

    require("config.lsp_keymaps").on_attach(client, bufnr)
    lsp_highlight(client, bufnr)

    -- local lspconfig_defaults = require("lspconfig").util.default_config
    -- lspconfig_defaults.capabilities =
    --   vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

    -- -- Handle formatting through a single autocommand
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_clear_autocmds {
        group = augroups.autoformat,
        buffer = bufnr,
      }
      -- vim.api.nvim_create_autocmd("BufWritePre", {
      --   group = augroups.autoformat,
      --   buffer = bufnr, -- Make this buffer-local
      --   callback = function()
      --     vim.lsp.buf.format {
      --       timeout_ms = 500,
      --       bufnr = bufnr,
      --     }
      --   end,
      -- })
    end
  end,
})
