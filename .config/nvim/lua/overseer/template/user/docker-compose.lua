return {
  name = "Docker Compose Up",
  desc = "Run Docker Compose up command",
  condition = {
    callback = function(_)
      local cwd = vim.fn.getcwd()
      local docker_compose_file = cwd .. "/docker-compose.yml"
      return vim.fn.filereadable(docker_compose_file) == 1
    end,
  },
  params = {
    services = {
      type = "list",
      subtype = { type = "string" },
      delimiter = " ",
      optional = true,
      desc = "Space-separated list of services to target",
    },
    detached = {
      type = "boolean",
      default = false,
      desc = "Run in detached mode",
    },
  },
  builder = function(params)
    local cmd = { "docker", "compose", "up" }

    if params.services and #params.services > 0 then
      for _, service in ipairs(params.services) do
        table.insert(cmd, service)
      end
    end

    if params.detached then table.insert(cmd, "-d") end

    return {
      cmd = cmd,
      cwd = vim.fn.getcwd(),
      components = {
        "default",
        { "on_output_summarize" },
      },
    }
  end,
}
