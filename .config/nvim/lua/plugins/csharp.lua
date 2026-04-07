return {
  {
    "seblyng/roslyn.nvim",
    dependencies = {
      "mason-org/mason.nvim",
    },
    ft = { "cs", "csproj", "vb", "fsproj" },
    keys = {
      { "<leader>cr", function() vim.lsp.buf.code_action() end, desc = "Code Actions", ft = "cs" },
      { "<leader>cR", function() vim.cmd "Roslyn.FixAll" end, desc = "Fix All Issues", ft = "cs" },
      { "<leader>cd", function() vim.lsp.buf.definition() end, desc = "Go to Definition", ft = "cs" },
      { "<leader>cD", function() vim.lsp.buf.declaration() end, desc = "Go to Declaration", ft = "cs" },
      { "<leader>ci", function() vim.lsp.buf.implementation() end, desc = "Go to Implementation", ft = "cs" },
      { "<leader>ct", function() vim.lsp.buf.type_definition() end, desc = "Go to Type Definition", ft = "cs" },
      { "<leader>cu", function() vim.lsp.buf.references() end, desc = "Find References", ft = "cs" },
      { "<leader>cn", function() vim.lsp.buf.rename() end, desc = "Rename Symbol", ft = "cs" },
      { "<leader>cf", function() vim.lsp.buf.format() end, desc = "Format Document", ft = "cs" },
      { "<leader>ch", function() vim.lsp.buf.hover() end, desc = "Show Documentation", ft = "cs" },
      { "<leader>cs", function() vim.lsp.buf.signature_help() end, desc = "Signature Help", ft = "cs" },
    },
    opts = {
      config = {
        roslyn_version = "latest",
        broad_search = true,
        settings = {
          ["csharp|completion"] = {
            dotnet_show_completion_items_from_unimported_namespaces = true,
            dotnet_show_name_completion_suggestions = true,
          },
          ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
            dotnet_enable_tests_code_lens = true,
          },
          ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_indexer_parameters = true,
            dotnet_enable_inlay_hints_for_literal_parameters = true,
            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
            dotnet_enable_inlay_hints_for_other_parameters = true,
            dotnet_enable_inlay_hints_for_parameters = true,
            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = false,
            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = false,
            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = false,
          },
          ["csharp|background_analysis"] = {
            dotnet_analyzer_diagnostics_scope = "fullSolution",
            dotnet_compiler_diagnostics_scope = "fullSolution",
          },
          ["csharp|symbol_search"] = {
            dotnet_search_reference_assemblies = true,
          },
          ["csharp|formatting"] = {
            dotnet_organize_imports_on_format = true,
            dotnet_sort_system_directives_first = true,
          },
          ["csharp|code_action"] = {
            dotnet_enable_organize_imports_code_action = true,
            dotnet_enable_remove_unnecessary_imports_code_action = true,
          },
        },
      },
    },
    config = function(_, opts) require("roslyn").setup(opts) end,
  },
  {
    "Hoffs/omnisharp-extended-lsp.nvim",
    ft = { "cs" },
    config = function()
      -- Enhanced go-to-definition for decompiled sources
      local extended = require "omnisharp_extended"
      vim.api.nvim_create_autocmd("LspAttach", {
        pattern = "*.cs",
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "roslyn" then
            vim.keymap.set(
              "n",
              "gd",
              extended.lsp_definitions,
              { buffer = args.buf, desc = "Go to Definition (Extended)" }
            )
            vim.keymap.set(
              "n",
              "gi",
              extended.lsp_implementation,
              { buffer = args.buf, desc = "Go to Implementation (Extended)" }
            )
            vim.keymap.set(
              "n",
              "gr",
              extended.lsp_references,
              { buffer = args.buf, desc = "Find References (Extended)" }
            )
            vim.keymap.set(
              "n",
              "gt",
              extended.lsp_type_definition,
              { buffer = args.buf, desc = "Go to Type Definition (Extended)" }
            )
          end
        end,
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    optional = true,
    opts = function(_, opts)
      -- Add C# specific file extensions and icons
      opts.filesystem = opts.filesystem or {}
      opts.filesystem.filtered_items = opts.filesystem.filtered_items or {}
      opts.filesystem.filtered_items.hide_dotfiles = false
      opts.filesystem.filtered_items.hide_hidden = false

      -- Show solution and project files prominently
      opts.filesystem.filtered_items.never_show = {
        ".git",
        "node_modules",
        ".cache",
      }

      opts.window = opts.window or {}
      opts.window.mappings = opts.window.mappings or {}
    end,
  },
}
