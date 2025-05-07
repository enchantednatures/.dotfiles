local M = {}

function M.has_cargo()
  local cwd = vim.fn.getcwd()
  local cargo_toml_file = cwd .. "/Cargo.toml"

  if vim.fn.filereadable(cargo_toml_file) ~= 1 then return false end
  return true
end

function M.get_rust_targets()
  if M.has_cargo() == false then
    vim.notify("No Cargo.toml found in the current directory", vim.log.levels.DEBUG)
    return {}
  end

  local cargo_output = vim.fn.system "cargo metadata --no-deps --format-version 1"
  local json = vim.fn.json_decode(cargo_output)
  local packages = {}
  for _, package in ipairs(json.packages) do
    for _, target in ipairs(package.targets) do
      if vim.tbl_contains(target.kind, "bin") then table.insert(packages, target.name) end
    end
  end

  return packages
end

return M
