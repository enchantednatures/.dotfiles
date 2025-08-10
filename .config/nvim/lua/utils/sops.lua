local function get_age_public_key()
  local key_file = os.getenv("SOPS_AGE_KEY_FILE")
  if not key_file then
    vim.notify("SOPS_AGE_KEY_FILE environment variable not set", vim.log.levels.ERROR)
    return nil
  end

  local handle = io.popen(string.format('rg -ioP "public key: \\K(.*$)" %s', key_file))
  if not handle then return nil end

  local public_key = handle:read("*a")
  handle:close()

  public_key = public_key:gsub("^%s*(.-)%s*$", "%1")
  return public_key
end

local function is_sops_encrypted()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  if not lines or #lines == 0 then return false end

  for i = 1, math.min(#lines, 50) do
    if lines[i]:match("^%s*sops:%s") or lines[i]:match('"sops"%s*:') then
      return true
    end
  end
  return false
end

local function decrypt_sops()
  local filepath = vim.fn.expand("%:p")
  local cmd = string.format("sops --decrypt %s", vim.fn.shellescape(filepath))

  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local handle = io.popen(cmd)
  if not handle then return end

  local decrypted = handle:read("*a")
  handle:close()

  if decrypted and decrypted ~= "" then
    vim.bo.swapfile = false
    vim.bo.undofile = false
    local lines = vim.split(decrypted, "\n", { plain = true })
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    vim.api.nvim_win_set_cursor(0, cursor_pos)
    vim.b.sops_decrypted = true
    vim.notify("SOPS file decrypted", vim.log.levels.INFO)
  else
    vim.notify("Failed to decrypt SOPS file", vim.log.levels.ERROR)
  end
end

local function encrypt_sops()
  local public_key = get_age_public_key()
  if not public_key then return end

  local filepath = vim.fn.expand("%:p")
  local cmd = string.format(
    "sops --encrypt --in-place --age %s %s",
    public_key,
    vim.fn.shellescape(filepath)
  )

  local result = os.execute(cmd)
  if result ~= 0 then
    vim.notify("Failed to encrypt with SOPS", vim.log.levels.ERROR)
  else
    vim.notify("File encrypted with SOPS", vim.log.levels.INFO)
    vim.b.sops_decrypted = nil
  end
end

local function handle_sops_file()
  if not is_sops_encrypted() then return end
  vim.ui.input({ prompt = "Decrypt SOPS file? (y/N): " }, function(input)
    if input and input:lower() == "y" then decrypt_sops() end
  end)
end

vim.api.nvim_create_augroup("SOPS", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
  group = "SOPS",
  pattern = "*.sops.yaml",
  callback = handle_sops_file,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    if vim.b.sops_decrypted then
      encrypt_sops()
    end
  end,
})

vim.api.nvim_create_user_command("Sops", function(opts)
  local sub = opts.fargs[1]
  if sub == "encrypt" then
    encrypt_sops()
  elseif sub == "decrypt" then
    decrypt_sops()
  else
    vim.notify("Invalid Sops subcommand. Use :Sops encrypt|decrypt", vim.log.levels.ERROR)
  end
end, {
  nargs = 1,
  complete = function() return { "encrypt", "decrypt" } end,
})

-- Wrapper for user command `:Sops encrypt|decrypt`
local function cmd_encrypt()
  encrypt_sops()
end

local function cmd_decrypt()
  decrypt_sops()
end


-- Set up autocommands for SOPS files
vim.api.nvim_create_augroup("SOPS", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
  group = "SOPS",
  pattern = "*.sops.yaml",
  callback = handle_sops_file,
})



-- Autocommand: encrypt on save if we previously decrypted the file
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*",
  callback = function()
    if is_sops_encrypted() then
      encrypt_sops()
    end
  end,
})



-- Register user command: `:Sops encrypt` or `:Sops decrypt`
vim.api.nvim_create_user_command("Sops", function(opts)
  local sub = opts.fargs[1]
  if sub == "encrypt" then
    cmd_encrypt()
  elseif sub == "decrypt" then
    cmd_decrypt()
  else
    vim.notify("Invalid Sops subcommand. Use :Sops encrypt|decrypt", vim.log.levels.ERROR)
  end
end, {
  nargs = 1,
  complete = function(_, _, _)
    return { "encrypt", "decrypt" }
  end,
})

