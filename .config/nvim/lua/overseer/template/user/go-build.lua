return {
  name = "go build",
  desc = "Build Go project",
  params = {
    output = {
      type = "string",
      optional = true,
      desc = "file to build out to",
    },
  },
  builder = function(params)
    print "buildings"
    local args = { "build" }
    if params.output then
      table.insert(args, "-o")
      table.insert(args, params.output)
    end

    -- print "args seting"

    -- if params.args and #params.args > 0 then
    --   for _, arg in ipairs(params.args) do
    --     table.insert(args, arg)
    --   end
    -- end
    -- print "args set"

    return {
      cmd = { "go" },
      args = args,
      cwd = vim.fn.getcwd(),
      components = {
        "default",
        { "on_output_summarize" },
        -- { "on_output_quickfix", open = true },
      },
    }
  end,
  condition = {
    filetype = { "go" },
  },
}
