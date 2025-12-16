-- Python environment detection and management
-- Supports uv venvs, standard venvs, and pyenv

local M = {}

---Check if a file exists
---@param path string
---@return boolean
local function file_exists(path) return vim.fn.filereadable(path) == 1 end

---Check if a directory exists
---@param path string
---@return boolean
local function dir_exists(path) return vim.fn.isdirectory(path) == 1 end

---Find the Python venv path
---Searches for venv directories in order of preference:
---1. .venv (most common and uv default)
---2. venv (standard Python convention)
---3. env (alternative convention)
---@param root string Root directory to search from
---@return string|nil Path to venv directory
function M.find_venv(root)
  local venv_names = { ".venv", "venv", "env" }

  for _, name in ipairs(venv_names) do
    local venv_path = root .. "/" .. name
    if dir_exists(venv_path) then return venv_path end
  end

  return nil
end

---Get the Python interpreter path from a venv
---@param venv_path string Path to venv directory
---@return string|nil Path to Python executable
function M.get_python_interpreter(venv_path)
  if not venv_path then return nil end

  -- Try Unix-style path first (.venv/bin/python)
  local python_path = venv_path .. "/bin/python"
  if file_exists(python_path) then return python_path end

  -- Try Windows-style path (.venv/Scripts/python.exe)
  python_path = venv_path .. "/Scripts/python.exe"
  if file_exists(python_path) then return python_path end

  return nil
end

---Find the root directory of a Python project
---Looks for common Python project markers
---@param start_path string|nil Starting path (defaults to cwd)
---@return string|nil Root path
function M.find_project_root(start_path)
  start_path = start_path or vim.fn.getcwd()

  local root_markers = {
    ".git",
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
  }

  local current = start_path
  local home = vim.fn.expand "~"

  while current ~= home and current ~= "/" do
    for _, marker in ipairs(root_markers) do
      local marker_path = current .. "/" .. marker
      if file_exists(marker_path) or dir_exists(marker_path) then return current end
    end
    current = vim.fn.fnamemodify(current, ":h")
  end

  return nil
end

---Get Python path configuration for LSP
---This returns the Python interpreter path and additional paths for type checking
---@param root string Project root directory
---@return table Configuration table with python paths
function M.get_python_config(root)
  root = root or M.find_project_root()

  local config = {
    pythonPath = nil,
    extraPaths = {},
  }

  if not root then return config end

  local venv_path = M.find_venv(root)
  if venv_path then
    local python_exe = M.get_python_interpreter(venv_path)
    if python_exe then
      config.pythonPath = python_exe
      -- Add venv site-packages to extra paths for type checking
      local site_packages = venv_path .. "/lib/python*/site-packages"
      table.insert(config.extraPaths, site_packages)
    end
  end

  return config
end

---Check if a venv was created by uv
---@param venv_path string Path to venv directory
---@return boolean
function M.is_uv_venv(venv_path)
  if not venv_path then return false end

  -- uv venvs have a pyvenv.cfg with uv marker or .uv directory marker
  local pyvenv_cfg = venv_path .. "/pyvenv.cfg"
  if file_exists(pyvenv_cfg) then
    local content = vim.fn.readfile(pyvenv_cfg)
    for _, line in ipairs(content) do
      if line:match "uv" then return true end
    end
  end

  return false
end

---Get type checker configuration for a project
---@param root string Project root directory
---@return table Configuration for type checking
function M.get_type_checker_config(root)
  root = root or M.find_project_root()

  local config = {
    mypy = {
      enabled = false,
      path = nil,
      config_file = nil,
    },
    pyright = {
      enabled = true,
      pythonPath = nil,
    },
  }

  if not root then return config end

  -- Check for mypy
  local mypy_ini = root .. "/mypy.ini"
  local pyproject = root .. "/pyproject.toml"

  if file_exists(mypy_ini) then
    config.mypy.enabled = true
    config.mypy.config_file = mypy_ini
  elseif file_exists(pyproject) then
    -- Check if mypy is configured in pyproject.toml
    local content = vim.fn.readfile(pyproject)
    local found_mypy = false
    for _, line in ipairs(content) do
      if line:match "%[tool%.mypy" then
        found_mypy = true
        break
      end
    end
    if found_mypy then config.mypy.enabled = true end
  end

  -- Configure venv for type checking
  local venv_path = M.find_venv(root)
  if venv_path then
    local python_exe = M.get_python_interpreter(venv_path)
    if python_exe then
      config.pyright.pythonPath = python_exe
      config.mypy.path = python_exe
    end
  end

  return config
end

---Check if mypy is available and configured
---@param root string|nil Project root (defaults to current project)
---@return boolean
function M.has_mypy(root)
  local config = M.get_type_checker_config(root)
  return config.mypy.enabled
end

---Check if pyright/basedpyright is available
---@return boolean
function M.has_pyright()
  return vim.fn.executable "basedpyright-langserver" == 1 or vim.fn.executable "pyright-langserver" == 1
end

---Initialize Python environment detection for current buffer
---Sets up LSP settings if venv is detected
function M.setup()
  local root = M.find_project_root()
  if not root then return end

  local venv_path = M.find_venv(root)
  if venv_path then
    local is_uv = M.is_uv_venv(venv_path)

    -- Notify user about venv detection
    local notify = require "utils.notify"
    local venv_type = is_uv and "uv venv" or "venv"
    notify.notify(string.format("Python %s detected: %s", venv_type, venv_path), { title = "Python Environment" })
  end

  -- Check type checker configuration
  local type_config = M.get_type_checker_config(root)
  if type_config.mypy.enabled then
    local notify = require "utils.notify"
    notify.notify("mypy configuration detected", { title = "Type Checking" })
  end
end

return M
