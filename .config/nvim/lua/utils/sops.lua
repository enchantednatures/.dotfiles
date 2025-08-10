local function is_sops_file()
  local filepath = vim.fn.expand "%:p"
  return filepath:match "%.sops%.ya?ml$"
end

local function is_sops_encrypted()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  for _, line in ipairs(lines) do
    if line:match "^%s*sops:%s*" then return true end
  end
  return false
end

local function decrypt_into_buffer(filepath)
  local cmd = string.format("sops --decrypt %s", vim.fn.shellescape(filepath))
  local handle = io.popen(cmd)
  if not handle then return false end
  local decrypted = handle:read "*a"
  handle:close()

  if decrypted and decrypted ~= "" then
    vim.bo.swapfile = false
    vim.bo.undofile = false
    local lines = vim.split(decrypted, "\n", { plain = true })
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    return true
  end
  return false
end

-- encrypt the current buffer using the real file name
-- so that .sops.yaml rules are applied.
-- Returns true on success, false otherwise.
local function encrypt_from_buffer(filepath, config_path)
  -- Write current buffer to its file (creates/overwrites the target file)
  vim.cmd("write! " .. vim.fn.fnameescape(filepath))

  -- Resolve the .sops.yaml file to use (default: ./.sops.yaml)
  local cfg = config_path or vim.fn.getcwd() .. "/.sops.yaml"
  local escaped_cfg = vim.fn.shellescape(cfg)

  -- Build command: set SOPS_CONFIG env var and encrypt in‑place.
  local cmd = string.format("SOPS_CONFIG=%s sops --encrypt -i %s", escaped_cfg, vim.fn.shellescape(filepath))

  local result = os.execute(cmd)
  return result == 0
end

-- Autocommands
local sops_group = vim.api.nvim_create_augroup("SOPS", { clear = true })

-- Decrypt on read
vim.api.nvim_create_autocmd("BufReadPost", {
  group = sops_group,
  pattern = { "*.sops.yaml", "*.sops.yml" },
  callback = function()
    local filepath = vim.fn.expand "%:p"
    if is_sops_file() and is_sops_encrypted() then
      if decrypt_into_buffer(filepath) then vim.notify("SOPS file decrypted in buffer", vim.log.levels.DEBUG) end
    end
  end,
})

-- Intercept write to encrypt without triggering file change warning
vim.api.nvim_create_autocmd("BufWriteCmd", {
  group = sops_group,
  pattern = { "*.sops.yaml", "*.sops.yml" },
  callback = function()
    local filepath = vim.fn.expand "%:p"
    if is_sops_file() and not is_sops_encrypted() then
      if encrypt_from_buffer(filepath) then
        vim.notify("SOPS file encrypted on disk", vim.log.levels.DEBUG)
        -- Mark buffer as unmodified so Neovim doesn't think it needs saving
        vim.api.nvim_buf_set_option(0, "modified", false)
      else
        vim.notify("Failed to encrypt SOPS file", vim.log.levels.ERROR)
      end
    else
      -- If it's already encrypted, just write normally
      vim.cmd "write"
    end
  end,
})
