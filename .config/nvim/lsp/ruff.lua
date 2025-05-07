return {
  cmd = { "ruff", "server" },
  filetypes = { "py", "python" },
  single_file_support = true,
  root_markers = { ".git", ".venv", "requirements.txt" },
}
