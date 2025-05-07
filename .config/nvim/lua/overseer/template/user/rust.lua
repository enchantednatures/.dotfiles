local rust_utils = require "utils.rust"
local packages = rust_utils.get_rust_targets()

return {
  name = "Rust Binaries",
  desc = "Run Rust",
  condition = {
    callback = function(_) return rust_utils.has_cargo() end,
  },

  params = {
    bin = {
      type = "enum",
      choices = packages,
      default = packages[1],
    },
  },
  builder = function(params)
    local args = { "run", "--bin", params.bin }
    table.insert(args, params.solution)
    return {
      cmd = { "cargo" },
      args = args,
      cwd = vim.fn.getcwd(),
      components = {
        "default",
        { "on_output_summarize" },
        -- { "on_output_quickfix", open = true },
      },
    }
  end,
}
