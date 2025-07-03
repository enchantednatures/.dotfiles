local M = {}

require "utils.sops"
require "utils.kubernetes"
require "utils.diff"
require "utils.ai"
local diagnostics = require "utils.diagnostics"
diagnostics:setup_diagnostics()

-- Export platform detection
M.platform = require "utils.platform"

function M.quit()
  local bufnr = vim.api.nvim_get_current_buf()
  local buf_windows = vim.call("win_findbuf", bufnr)
  local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
  if modified and #buf_windows == 1 then
    vim.ui.input({
      prompt = "You have unsaved changes. Quit anyway? (y/n) ",
    }, function(input)
      if input == "y" then vim.cmd "qa!" end
    end)
  else
    vim.cmd "qa!"
  end
end

function M.find_files()
  local opts = {}
  local telescope = require("telescope").extensions.menufacture

  local ok = pcall(telescope.git_files, opts)
  if not ok then telescope.find_files(opts) end
end

function M.get_lsp_client(msg)
  msg = msg or "No Active Lsp"
  local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then return msg end
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then return client.name end
  end
  local util = require "utils.notify"
  util.notify(msg)
  return msg
end

vim.api.nvim_create_user_command(
  "GetActiveLspClient",
  function(args) M.get_lsp_client() end,
  { desc = "Open Git vertically", nargs = "*" }
)

vim.api.nvim_create_user_command("NullLsInfo", function()
  local sources = vim.lsp.get_active_clients({ bufnr = 0, name = "null-ls" })[1].config.sources
  for _, source in ipairs(sources) do
    print(source.name)
  end
end, {})

return M
