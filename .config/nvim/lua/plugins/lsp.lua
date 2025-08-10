return {
  {
    "mason-org/mason.nvim",
    event = { "BufReadPre", "BufNewFile", "VeryLazy" },
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
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      local opts = {
        ensure_installed = {
          "bashls",
          "buf_ls",
          "clangd",
          "docker_compose_language_service",
          "dockerls",
          "gopls",
          "graphql",
          "typescript-language-server",
          "helm_ls",
          "lua_ls",
          "ruff",
          "roslyn",
          "spectral",
          "terraformls",
          "ts_ls",
          "basedpyright",
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
          "csharpier",
          "gitsigns",
          "gofumpt",
          "goimports",
          "goimports-reviser",
          "golangci_lint",
          "gomodifytags",
          "google_java_format",
          "hadolint",
          "impl",
          "mypy",
          "prettier",
          "prettierd",
          "protolint",
          "shfmt",
          "spectral",
          "sqlfluff",
          "stylua",
          "terraform_validate",
        },
      }

      nls.setup {
        sources = {
          -- Code actions
          -- nls.builtins.code_actions.gitsigns.with {
          --   config = {
          --     filter_actions = function(title) return title:lower():match "blame" == nil end,
          --   },
          -- },
          nls.builtins.code_actions.gomodifytags,
          nls.builtins.code_actions.impl,

          -- Diagnostics
          nls.builtins.diagnostics.cmake_lint,
          nls.builtins.diagnostics.mypy,
          nls.builtins.diagnostics.hadolint,
          nls.builtins.diagnostics.cppcheck,
          nls.builtins.diagnostics.golangci_lint,
          nls.builtins.diagnostics.terraform_validate.with { command = "tofu" },
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
          cpp = { "clang_format" },
          cmake = { "cmake_format" },
          go = { "goimports", "goimports_reviser", "gofumpt" },
          html = { "htmlbeautifier", "deno_fmt" },
          rust = { "leptosfmt" },
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
