local Utils = require "utils.notify"

-- Function to create Ollama provider configurations
---@param config {endpoint: string, model: string, max_tokens: number}
---@return table

---@class EnvironmentHandler
local E = {}

---@private
---@type table<string, string>
E.cache = {}

E.parse_envvar = function(Opts)
  local api_key_name = Opts.api_key_name
  if api_key_name == nil then error "Requires api_key_name" end

  local cache_key = type(api_key_name) == "table" and table.concat(api_key_name, "__") or api_key_name

  if E.cache[cache_key] ~= nil then return E.cache[cache_key] end

  local cmd = type(api_key_name) == "table" and api_key_name or api_key_name:match "^cmd:(.*)"

  if cmd ~= nil then
    if type(cmd) == "string" then cmd = vim.split(cmd, " ", { trimempty = true }) end

    local result = vim.system(cmd, { text = true }):wait()
    if result.code == 0 and result.stdout then
      local value = vim.trim(result.stdout)
      E.cache[cache_key] = value
      vim.g.avante_login = true
      return value
    else
      Utils.error("Failed to get API key: " .. (result.stderr or ""))
      return nil
    end
  else
    local value = os.getenv(api_key_name)
    if value then
      E.cache[cache_key] = value
      vim.g.avante_login = true
    end
    return value
  end
end

return E
