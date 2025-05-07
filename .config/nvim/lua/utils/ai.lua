local M = {}

function M.create_open_webui_provider(config)
  local env_utils = require "utils.env"
  local api_key = env_utils.parse_envvar(config)
  if not api_key then return nil end
  return {
    __inherited_from = "openai",
    endpoint = config.endpoint or "localhost:11434/v1",
    model = config.model or "llama3.2:3b",
    api_key_name = "",
    parse_curl_args = function(opts)
      local url = opts.endpoint:gsub("/+$", "") .. "/api/chat/completions"

      return {

        url = url,
        method = "POST",
        headers = {
          ["Accept"] = "application/json",
          ["Content-Type"] = "application/json",
          ["Authorization"] = "Bearer " .. api_key,
        },
        body = {
          model = opts.model,
          messages = require("avante.providers").copilot.parse_messages(opts),
          max_tokens = config.max_tokens or 2048,
          stream = true,
        },
      }
    end,
  }
end

return M
