return {
  {
    "williamboman/mason.nvim",
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
          "astro",
          "bashls",
          "buf_ls",
          "clangd",
          -- "cmake",
          -- "cssls",
          "docker_compose_language_service",
          "dockerls",
          -- "dotls",
          "gopls",
          "graphql",
          -- "html",
          "typescript-language-server",
          -- "helm_ls",
          -- "jqls",
          "lua_ls",
          -- "nginx_language_server",
          -- "rust_analyzer",
          "ruff",
          "roslyn",
          "spectral",
          -- "sqls",
          -- "templ",
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
    dependencies = { "mason.nvim", "jay-babu/mason-null-ls.nvim", "nvimtools/none-ls-extras.nvim" },
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
          -- code_actions
          nls.builtins.code_actions.gitsigns.with {
            config = {
              filter_actions = function(title)
                return title:lower():match "blame" == nil -- filter out blame actions
              end,
            },
          },
          -- nls.builtins.code_actions.gitrebase,
          nls.builtins.code_actions.gomodifytags,
          nls.builtins.code_actions.impl,
          -- diagnostics
          nls.builtins.diagnostics.cmake_lint,
          nls.builtins.diagnostics.mypy,
          nls.builtins.diagnostics.hadolint,
          nls.builtins.diagnostics.cppcheck,
          -- nls.builtins.diagnostics.spectral.with {
          --   condition = function(utils)
          --     return utils.root_has_file "*spec.yaml" or string.match(vim.fn.expand "%", "spec%.yaml$")
          --   end,
          -- },
          nls.builtins.diagnostics.golangci_lint,
          -- nls.builtins.diagnostics.sqlfluff.with { extra_args = { "--dialect", "postgres" } },
          nls.builtins.diagnostics.terraform_validate.with { command = "tofu" },
          nls.builtins.diagnostics.protolint,

          -- formatting
          nls.builtins.formatting.buf,
          nls.builtins.formatting.cbfmt,
          nls.builtins.formatting.clang_format,
          nls.builtins.formatting.cmake_format,
          -- nls.builtins.formatting.codespell,
          -- nls.builtins.formatting.csharpier,
          nls.builtins.formatting.goimports,
          nls.builtins.formatting.goimports_reviser,
          -- nls.builtins.formatting.gofmt,
          nls.builtins.formatting.gofumpt,
          nls.builtins.formatting.htmlbeautifier,

          nls.builtins.formatting.leptosfmt,
          nls.builtins.formatting.prettierd.with { filetypes = { "html", "json","yaml",  "markdown" } },
          nls.builtins.formatting.google_java_format,
          nls.builtins.formatting.shfmt,
          nls.builtins.formatting.sqlfluff.with { extra_args = { "--dialect", "postgres" } },
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.terraform_fmt.with { command = "tofu" },
        },
      }
    end,
  },
}
