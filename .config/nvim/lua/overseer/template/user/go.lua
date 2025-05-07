return {
  name = "go test",
  desc = "Run tests for go project",
  builder = function()
    return {
      cmd = { "go" },
      args = { "test", "./..." },
      cwd = vim.fn.getcwd(),
      components = {
        { "on_output_quickfix", open = true },
        "default",
      },
    }
  end,
  condition = {
    filetype = { "go" },
  },
}
