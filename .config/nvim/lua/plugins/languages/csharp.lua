return {
  {
    "Issafalcon/neotest-dotnet",
    lazy = true,
    event = { "BufReadPre" },
    ft = { "cs", "csproj" },
    dependencies = {
      "nvim-neotest/neotest",
      "mfussenegger/nvim-dap",
    },
    config = function()
      local neotest_dotnet = require "neotest-dotnet"
      require("neotest").setup {
        adapters = {
          neotest_dotnet {
            dap = {
              adapter_name = "coreclr",
              enabled = true,
            },
            discovery_root = "solution",
            discovery_recursive = true,
            output_live = true,
          },
        },
      }
    end,
  },
  {
    "seblyng/roslyn.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    lazy = true,
    event = { "VeryLazy", "BufReadPre" },
    ft = { "cs", "csproj" },
    opts = {
      config = {
        roslyn_version = "latest",
        broad_search = true,
        settings = {
          ["csharp|completion"] = {
            dotnet_show_completion_items_from_unimported_namespaces = true,
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
            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
          },
          ["csharp|background_analysis"] = {
            background_analysis = {
              dotnet_analyzer_diagnostics_scope = "fullSolution",
              dotnet_compiler_diagnostics_scope = "fullSolution",
            },
          },
          ["csharp|symbol_search"] = {
            dotnet_search_reference_assemblies = true,
          },
          ["csharp|formatting"] = {
            dotnet_organize_imports_on_format = true,
          },
        },
      },
    },
    config = function(_, opts) require("roslyn").setup(opts) end,
  },
}
