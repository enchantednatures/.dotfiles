return {
  cmd = { "bash-language-server", "start" },
  filetypes = { "bash", "sh" },
  single_file_support = true,
  settings = {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command)",
    },
  },
}
