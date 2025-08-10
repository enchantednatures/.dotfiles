vim.g.mapleader = " "

require "config.options"
require "config.lazy"
require "config.autocommands"

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function() vim.lsp.inlay_hint.enable() end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require "config.keymaps"

    vim.diagnostic.config {
      virtual_text = false,
      virtual_lines = { only_current_line = true },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "",
          [vim.diagnostic.severity.WARN] = "",
          [vim.diagnostic.severity.INFO] = "",
          [vim.diagnostic.severity.HINT] = "",
        },
        linehl = {
          [vim.diagnostic.severity.ERROR] = "ErrorMsg",
        },
        numhl = {
          [vim.diagnostic.severity.WARN] = "WarningMsg",
        },
      },
      update_in_insert = true,
      underline = true,
      severity_sort = false,
      float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    }
  end,
})

-- local sign = function(opts)
--   vim.fn.sign_define(opts.name, {
--     texthl = opts.name,
--     text = opts.text,
--     numhl = ""
--   })
-- end

-- sign({ name = "DiagnosticSignError", text ="" })
-- sign({ name = "DiagnosticSignWarn", text = "" })
-- sign({ name = "DiagnosticSignHint", text = "" })
-- sign({ name = "DiagnosticSignInfo", text = "" })

vim.api.nvim_create_autocmd("User", {
  pattern = "*",
  callback = function()
    local groups = {
      "BufferLine",
      "Comment",
      "Conditional",
      "Constant",
      "CursorLine",
      "CursorLineNr",
      "EndOfBuffer",
      "Function",
      "FidgetTitle",
      "FidgetTask",
      "Identifier",
      "LineNr",
      "NonText",
      "Normal",
      "NormalFloat",
      "NormalNC",
      "NormalSB",
      "Operator",
      "PreProc",
      "Repeat",
      "SignColumn",
      "Special",
      "Statement",
      "StatusLine",
      "StatusLineNC",
      "String",
      "Structure",
      "TelescopeNormal",
      "Todo",
      "Type",
      "Underlined",
    }

    for _, v in ipairs(groups) do
      local ok, prev_attrs = pcall(vim.api.nvim_get_hl_by_name, v, true)
      if ok and (prev_attrs.background or prev_attrs.bg or prev_attrs.ctermbg) then
        local attrs = vim.tbl_extend("force", prev_attrs, { bg = "NONE", ctermbg = "NONE" })
        attrs[true] = nil
        vim.api.nvim_set_hl(0, v, attrs)
      end
    end
  end,
})

vim.lsp.set_log_level "ERROR"
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
  -- "denols",
  "graphql",
  "jsonls",
  "lua_ls",
  "ruff",
  "terraform-ls",
  "yamlls",
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "aql",
  callback = function()
    parser_config.aql = {
      install_info = {
        url = "~/dev/tree-sitter-aql/",
        files = { "src/parser.c" },
        branch = "main",
        generate_requires_npm = false,
        requires_generate_from_grammar = false,
        highlight = { enable = true },
      },

      highlight = { enable = true },
      filetype = "aql",
    }

    vim.filetype.add {
      extension = {
        aql = "aql",
      },
      filename = {
        ["aql"] = "aql",
      },
    }
  end,
})
