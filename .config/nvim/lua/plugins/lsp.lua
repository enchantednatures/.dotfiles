-- ============================================================================
-- Module: plugins/lsp.lua
-- Description: LSP ecosystem - mason, lspconfig, none-ls, conform
-- Dependencies: mason.nvim, nvim-lspconfig
-- ============================================================================

return {
  {
    "mason-org/mason.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonLog", "MasonUpdate" },
    config = function()
      require("mason").setup {
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      }
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    config = function()
      local opts = {
        ensure_installed = {
          "basedpyright",
          "bashls",
          "buf_ls",
          "clangd",
          "denols",
          "docker_compose_language_service",
          "dockerls",
          "gh-actions-language-server",
          "gopls",
          "graphql",
          "helm_ls",
          "lua_ls",
          "roslyn",
          "ruff",
          "terraform-ls",
          "ts_ls",
          "typescript-language-server",
          "yamlls",
        },
        automatic_installation = {
          exclude = {
            "rust_analyzer",
            "solargraph",
          },
        },
        handlers = {},
      }
      require("mason-lspconfig").setup(opts)
    end,
  },
  -- ============================================================================
  -- None-ls (formerly null-ls) - Audit Note
  -- 
  -- Purpose: Provides code actions and diagnostics not available via LSP
  -- 
  -- Current Usage:
  --   Code Actions:
  --     - gomodifytags: Modify Go struct tags (add/remove/edit json/db tags)
  --     - impl: Generate Go interface implementations
  --   
  --   Diagnostics (Linting):
  --     - cmake_lint: CMakeLists.txt linting
  --     - hadolint: Dockerfile linting  
  --     - cppcheck: C/C++ static analysis
  --     - golangci_lint: Go comprehensive linting
  --     - terraform_validate: Terraform validation (using tofu)
  --     - opentofu_validate: OpenTofu validation
  --     - protolint: Protocol Buffers linting
  --
  -- Overlap with conform.nvim:
  --   - Formatting: conform.nvim handles all formatting (none-ls not used)
  --   - This config only uses none-ls for code actions and diagnostics
  --
  -- To Remove None-ls:
  --   1. Find alternatives for Go code actions (gomodifytags, impl)
  --   2. Ensure LSPs provide equivalent diagnostics, OR
  --   3. Use standalone linters with custom autocmds
  -- ============================================================================
  {
    "nvimtools/none-ls.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "jay-babu/mason-null-ls.nvim",
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      local nls = require "null-ls"
      local mason_null_ls = require "mason-null-ls"

      mason_null_ls.setup {
        ensure_installed = {
          "buf",
          "cbfmt",
          "clang_format",
          "cmake_format",
          "cmake_lint",
          "codespell",
          "gitsigns",
          "gofumpt",
          "goimports",
          "goimports-reviser",
          "golangci_lint",
          "gomodifytags",
          "google_java_format",
          "impl",
          "prettier",
          "prettierd",
          "protolint",
          "shfmt",
          "sqlfluff",
          "stylua",
        },
      }

      nls.setup {
        sources = {
          -- Code actions
          nls.builtins.code_actions.gomodifytags,
          nls.builtins.code_actions.impl,

          -- Diagnostics
          nls.builtins.diagnostics.cmake_lint,
          nls.builtins.diagnostics.hadolint,
          nls.builtins.diagnostics.cppcheck,
          nls.builtins.diagnostics.golangci_lint,
          nls.builtins.diagnostics.terraform_validate.with { command = "tofu" },
          nls.builtins.diagnostics.opentofu_validate,
          nls.builtins.diagnostics.protolint,
        },
      }
    end,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
      require("conform").setup {
        formatters_by_ft = {
          proto = { "buf" },
          markdown = { "cbfmt", "deno_fmt" },
          c = { "clang_format" },
          python = function(bufnr)
            if require("conform").get_formatter_info("ruff_format", bufnr).available then
              return { "ruff_format" }
            else
              return { "isort", "black" }
            end
          end,
          cpp = { "clang_format" },
          cmake = { "cmake_format" },
          go = { "goimports", "goimports_reviser", "gofumpt" },
          html = { "htmlbeautifier", "deno_fmt" },
          toml = { "taplo" },
          rust = { "rustfmt", "leptosfmt", lsp_format = "fallback" },
          json = { "prettierd" },
          typescript = { "deno_fmt" },
          javascript = { "deno_fmt" },
          yaml = { "prettierd" },
          java = { "google_java_format" },
          sh = { "shfmt" },
          sql = { "sqlfluff" },
          lua = { "stylua" },
          terraform = { "terraform_fmt" },
        },
        format_on_save = {
          timeout_ms = 1000,
          lsp_fallback = true,
        },
        formatters = {
          sqlfluff = {
            prepend_args = { "--dialect", "postgres" },
          },
          terraform_fmt = {
            command = "tofu",
          },
          deno_fmt = {
            command = "deno",
            args = { "fmt", "-" }, -- read from stdin
            stdin = true,
          },
        },
      }
    end,
  },
}
