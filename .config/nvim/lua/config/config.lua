local M = {}

M.opts = {
  format_on_save = true,
  use_copilot = false,
  use_open_webui = false,
  use_minuet = false,
  use_claude = false,
  use_dotnet = false,
  use_go = true,
  use_rust = true,
  use_python = true,
  use_typescript = true,
  default_provider = "claude",
  mode = "agent",
  default_cursor_applying_provider = "claude-3-5-sonnet-20241022",
  enable_cursor_planning_mode = true,
}

return M
