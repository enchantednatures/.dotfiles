local function is_sops_file()
  local filepath = vim.fn.expand "%:p"
  return filepath:match "%.sops%.ya?ml$"
end

local function is_sops_encrypted()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  -- Look for a line that starts with the SOPS top‑level key
  for _, line in ipairs(lines) do
    if line:match "^%s*sops:%s*" then return true end
  end

  return false
end

local function decrypt_sops()
  local filepath = vim.fn.expand "%:p"
  local cmd = string.format("sops --decrypt %s", vim.fn.shellescape(filepath))

  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local handle = io.popen(cmd)
  if not handle then return end

  local decrypted = handle:read "*a"
  handle:close()

  if decrypted and decrypted ~= "" then
    vim.bo.swapfile = false
    vim.bo.undofile = false
    local lines = vim.split(decrypted, "\n", { plain = true })
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    vim.api.nvim_win_set_cursor(0, cursor_pos)
    vim.notify("SOPS file decrypted", vim.log.levels.DEBUG)
  else
    vim.notify("Failed to decrypt SOPS file", vim.log.levels.ERROR)
  end
end

local function encrypt_sops()
  local filepath = vim.fn.expand "%:p"
  local cmd = string.format("sops --encrypt --in-place %s", vim.fn.shellescape(filepath))

  local result = os.execute(cmd)
  if result ~= 0 then
    vim.notify("Failed to encrypt with SOPS", vim.log.levels.ERROR)
  else
    vim.notify("File encrypted with SOPS", vim.log.levels.DEBUG)
  end
end

local function handle_sops_file()
  if is_sops_file() and is_sops_encrypted() then decrypt_sops() end
end

-- Create augroup once
local sops_group = vim.api.nvim_create_augroup("SOPS", { clear = true })

-- Decrypt on read
vim.api.nvim_create_autocmd("BufReadPost", {
  group = sops_group,
  pattern = { "*.sops.yaml", "*.sops.yml" },
  callback = handle_sops_file,
})

-- Encrypt before write
vim.api.nvim_create_autocmd("BufWritePost", {
  group = sops_group,
  pattern = { "*.sops.yaml", "*.sops.yml" },
  callback = function()
    if is_sops_file() and not is_sops_encrypted() then
      encrypt_sops()
      vim.cmd "edit!"
    end
  end,
})

-- Manual command
vim.api.nvim_create_user_command("Sops", function(opts)
  if opts.fargs[1] == "encrypt" then
    encrypt_sops()
  elseif opts.fargs[1] == "decrypt" then
    decrypt_sops()
  else
    vim.notify("Usage: :Sops encrypt|decrypt", vim.log.levels.ERROR)
  end
end, {
  nargs = 1,
  complete = function() return { "encrypt", "decrypt" } end,
})
