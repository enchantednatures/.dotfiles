local M = {}

M.opts = {
  format_on_save = true,
  use_topsail = true,
  use_copilot = false,
  use_open_webui = false,
  use_minuet = true,
  use_claude = false,
  use_dotnet = false,
  use_go = true,
  use_rust = true,
  use_python = true,
  use_typescript = true,
  default_provider = "groq",
  default_cursor_applying_provider = "groq_llama",
  enable_cursor_planning_mode = true,
}

return M
