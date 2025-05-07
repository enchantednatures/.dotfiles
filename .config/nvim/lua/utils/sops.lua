local function get_age_public_key()
  local key_file = os.getenv "SOPS_AGE_KEY_FILE"
  if not key_file then
    vim.notify("SOPS_AGE_KEY_FILE environment variable not set", vim.log.levels.ERROR)
    return nil
  end

  local handle = io.popen(string.format('rg -ioP "public key: \\K(.*$)" %s', key_file))
  if not handle then return nil end

  local public_key = handle:read "*a"
  handle:close()

  -- Trim whitespace
  public_key = public_key:gsub("^%s*(.-)%s*$", "%1")
  return public_key
end

-- Function to decrypt SOPS file
local function decrypt_sops()
  local public_key = get_age_public_key()
  if not public_key then return end

  local filepath = vim.fn.expand "%:p"
  local cmd = string.format("sops --decrypt --age %s %s", public_key, filepath)

  -- Save current cursor position
  local cursor_pos = vim.api.nvim_win_get_cursor(0)

  -- Get decrypted content
  local handle = io.popen(cmd)
  if not handle then return end

  local decrypted = handle:read "*a"
  handle:close()

  if decrypted then
    -- Replace buffer contents with decrypted data
    local lines = vim.split(decrypted, "\n", { plain = true })
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

    -- Restore cursor position
    vim.api.nvim_win_set_cursor(0, cursor_pos)
  end
end

-- Function to handle SOPS file opening
local function handle_sops_file()
  vim.ui.input({
    prompt = "Decrypt SOPS file? (y/N): ",
  }, function(input)
    if input and input:lower() == "y" then decrypt_sops() end
  end)
end

-- Set up autocommands for SOPS files
vim.api.nvim_create_augroup("SOPS", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
  group = "SOPS",
  pattern = "*.sops.yaml",
  callback = handle_sops_file,
})
