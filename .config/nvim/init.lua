vim.g.mapleader = " "

require "config.options"
require "config.lazy"
require "config.autocommands"

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function() require "config.keymaps" end,
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

local disabled_deprecation_warnings = {
  "vim.treesitter.query",
  "vim.treesitter.parse_query",
  "for_each_child",
  "client.supports_method",
  "client.request",
  "client.is_stopped",
  "client.notify",
}

local orig_deprecate = vim.deprecate

local filter_deprecate = function(name, ...)
  for _, disabled in pairs(disabled_deprecation_warnings) do
    if name:find(disabled, 1, true) then return end
  end
  orig_deprecate(name, ...)
end

vim.deprecate = filter_deprecate
vim.lsp.set_log_level "ERROR"
vim.lsp.config("*", {
  root_markers = { ".git" },
})
vim.lsp.enable {
  "basedpyright",
  "bashls",
  "buf_ls",
  "clangd",
  "dockerls",
  "docker_compose_language_service",
  "graphql",
  "jsonls",
  "lua_ls",
  "ruff",
  "terraform-ls",
  "ts-ls",
  "yamlls",
}

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

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

vim.lsp.inlay_hint.enable()

vim.api.nvim_create_user_command(
  "CNPGWorkspace",
  function() require("utils.telescope_cnpg_workspace").cnpg_workspace() end,
  {}
)
