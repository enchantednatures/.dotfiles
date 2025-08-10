return {
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = true,
    event = { "BufReadPre", "BufNewFile", "VeryLazy" },
    ft = { "rust", "toml" },
    config = function()
      local codelldb_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/bin/codelldb")
      local cfg = require "rustaceanvim.config"
      vim.g.rustaceanvim = {
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path),
        },
        tools = {
          runnables = {
            use_telescope = true,
          },
          hover_actions = {
            auto_focus = false,
          },
          code_actions = {
            use_telescope = true,
          },
        },
        server = {
          on_attach = function(_, bufnr)
            vim.keymap.set(
              "n",
              "<leader>cb",
              function() vim.cmd.RustLsp { "runnables" } end,
              { desc = "[C]argo [B]uild" },
              { buffer = bufnr }
            )

            vim.lsp.inlay_hint.enable()
          end,
          rustc = {
            default_edition = "2024",
          },
          settings = {
            ["rust-analyzer"] = {
              diagnostics = {
                enable = false,
              },
              capabilities = require("blink.cmp").get_lsp_capabilities {
                textDocument = {
                  completion = {
                    completionItem = {
                      snippetSupport = false,
                    },
                  },
                },
              },
              assist = {
                importEnforceGranularity = true,
                importPrefix = "crate",
              },
              imports = {
                granularity = {
                  group = "Item",
                },
                prefix = "self",
              },
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = {
                  enable = true,
                },
              },
              checkOnSave = {
                enable = true,
                allFeatures = true,
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
              lens = {
                enable = true,
              },
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["tracing"] = { "instrument" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                  leptos_macro = {
                    "server",
                  },
                },
              },
              inlayHints = {
                lifetimeElisionHints = {
                  enable = true,
                  useParameterNames = true,
                },
              },
              files = {
                excludeDirs = {
                  "_build",
                  ".dart_tool",
                  ".flatpak-builder",
                  ".git",
                  ".gitlab",
                  ".gitlab-ci",
                  ".gradle",
                  ".idea",
                  ".next",
                  ".project",
                  ".scannerwork",
                  ".settings",
                  ".venv",
                  "archetype-resources",
                  "bin",
                  "hooks",
                  "node_modules",
                  "po",
                  "screenshots",
                  "target",
                },
                watcherExclude = {
                  "**/target/**",
                  "**/node_modules/**",
                  "**/.git/**",
                  "**/.venv/**",
                },
              },
            },
          },
        },
      }
    end,
  },
  {
    "saecki/crates.nvim",
    lazy = true,
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    tag = "v0.4.0",
    opts = {},
    config = function(_, opts) require("crates").setup(opts) end,
  },
}
