local M = {}

-- Platform detection
function M.is_mac() return vim.fn.has "mac" == 1 end
function M.is_win() return vim.fn.has "win32" == 1 or vim.fn.has "win64" == 1 end
function M.is_wsl()
  local output = vim.fn.systemlist "uname -r"
  return output[1] and output[1]:lower():match "microsoft" ~= nil
end
function M.is_linux() return vim.fn.has "unix" == 1 and not M.is_mac() and not M.is_wsl() end

-- M.is_mac = M.is_mac()
-- M.is_win = M.is_win()
-- M.is_wsl = M.is_wsl()
-- M.is_linux = M.is_linux()

-- Path utilities for multiplatform support
function M.path_sep() return M.is_win and "\\" or "/" end

-- Get appropriate .NET paths based on platform
function M.get_dotnet_paths()
  local paths = {
    netcoredbg = nil, -- Debug adapter path
    dotnet = nil, -- dotnet CLI path
    omnisharp = nil, -- OmniSharp server path
  }

  -- Generic fallback is to look in PATH
  paths.dotnet = "dotnet"

  if M.is_mac() then
    paths.netcoredbg = vim.fn.expand "~/.local/share/nvim/mason/packages/netcoredbg/netcoredbg"
    paths.dotnet = "/opt/homebrew/bin/dotnet"
  elseif M.is_linux() then
    paths.netcoredbg = vim.fn.expand "~/.local/share/nvim/mason/packages/netcoredbg/netcoredbg"
  elseif M.is_wsl() then
    -- For WSL, we might need to handle Windows paths specially
    paths.netcoredbg = vim.fn.expand "~/.local/share/nvim/mason/packages/netcoredbg/netcoredbg"
  elseif M.is_win() then
    paths.netcoredbg = vim.fn.expand "~/AppData/Local/nvim-data/mason/packages/netcoredbg/netcoredbg.exe"
    paths.dotnet = "dotnet.exe"
  end

  return paths
end

-- Returns a list of DLLs from common debug output directories
function M.auto_discover_dotnet_dlls()
  local cwd = vim.fn.getcwd()
  local output = vim.fn.globpath(cwd .. "/bin/Debug", "**/*.dll", true, true)
  local filtered = vim.tbl_filter(
    function(path) return not path:match "ref/" and not path:match "deps.json" end,
    output
  )
  return filtered
end

return M
