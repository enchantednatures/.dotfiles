local find_solution_files = function()
  local solution_files = vim.fn.glob("*.sln", 1, true)
  local project_files = vim.fn.glob("*.csproj", 1, true)
  local files = {}
  for _, file in ipairs(solution_files) do
    table.insert(files, file)
  end
  for _, file in ipairs(project_files) do
    table.insert(files, file)
  end
  return files
end

return {
  name = "dotnet test",
  desc = "Run tests for .NET project or solution",

  params = {
    solution = {
      type = "enum",
      choices = find_solution_files(),
      default = find_solution_files()[1],
    },
    filter = {
      type = "enum",
      choices = { "Unit", "Integration", "Functional" },
      default = "Unit",
    },
    restore = {
      type = "boolean",
      default = true,
    },
  },
  builder = function(params)
    args = { "test", "--filter", params.filter }
    if not params.restore then table.insert(args, "--no-restore") end
    table.insert(args, params.solution)
    return {
      cmd = { "dotnet" },
      args = args, --,//{ "test", "--no-restore", "--filter", params.filter, vim.fn.getcwd() .. "/" .. params.solution },
      cwd = vim.fn.getcwd(),
      components = {
        "default",
        { "on_output_summarize" },
        -- { "on_output_quickfix", open = true },
      },
    }
  end,
  condition = {
    filetype = { "cs", "csproj" },
  },
}
