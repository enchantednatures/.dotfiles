local M = {}
local cache = {}
local cache_ttl = 60 -- seconds
local config = {
  kubernetes = {
    is_enabled = false,
    namespaces = nil, -- Set to nil to fetch from kubectl
  },
}

function M.get_namespaces()
  if not config.kubernetes.is_enabled then return { "default" } end
  if config.kubernetes and config.kubernetes.namespaces then return config.kubernetes.namespaces end
  if cache.namespaces and cache.namespaces.timestamp + cache_ttl > os.time() then return cache.namespaces.data end

  local cmd = "kubectl get ns -o jsonpath='{.items[*].metadata.name}'"
  local handle = io.popen(cmd)
  if not handle then return {} end

  local output = handle:read "*a"
  handle:close()

  output = output:gsub("^'", ""):gsub("'$", "")
  local namespaces = {}
  for ns in output:gmatch "%S+" do
    table.insert(namespaces, ns)
  end

  cache.namespaces = {
    data = namespaces,
    timestamp = os.time(),
  }

  return namespaces
end

function M.invalidate_cache() cache = {} end

return M
