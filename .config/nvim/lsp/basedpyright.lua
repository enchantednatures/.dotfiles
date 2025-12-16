local python_utils = require "utils.python"

return {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python", "py" },
  root_markers = { "pyproject.toml", ".git", ".venv", "setup.py", "requirements.txt" },
  enabled = true,
  single_file_support = true,
  before_init = function(_, config)
    -- Detect and configure venv if present
    local root_dir = config.root_dir
    if root_dir then
      local venv_path = python_utils.find_venv(root_dir)
      if venv_path then
        local python_exe = python_utils.get_python_interpreter(venv_path)
        if python_exe then
          config.settings.basedpyright = config.settings.basedpyright or {}
          config.settings.basedpyright.pythonPath = python_exe
        end
      end
    end
  end,
  settings = {
    disableOrganizeImports = true,
    basedpyright = {
      analysis = {
        -- Type checking configuration
        typeCheckingMode = "strict", -- strict, standard, basic, off
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
        venvPath = ".",
        -- Strict type checking options
        reportMissingImports = true,
        reportMissingTypeStubs = false,
        reportPrivateUsage = true,
        reportUnusedVariable = true,
        reportUnusedImport = true,
        reportIncompatibleMethodOverride = true,
        reportIncompatibleVariableOverride = true,
        reportAssignmentType = true,
        reportAttributeAccessIssue = true,
        reportCallIssue = true,
        reportConstantRedefinition = true,
        reportInvalidStringEscapeSequence = true,
        reportOptionalSubscript = true,
        reportOptionalMemberAccess = true,
        reportOptionalCall = true,
        reportOptionalIterable = true,
        reportOptionalContextManager = true,
        reportOptionalOperand = true,
        reportIndexIssue = true,
        reportReturnType = true,
        reportUnnecessaryIsInstance = true,
        reportUnnecessaryCast = true,
        reportUnnecessaryComparison = true,
        reportUnusedClass = true,
        reportUnusedFunction = true,
        reportUndefinedVariable = true,
      },
      pythonPath = nil, -- Will be set by before_init if venv is found
    },
    python = {
      pythonPath = nil,
      analysis = {
        extraPaths = {},
      },
    },
  },
}
