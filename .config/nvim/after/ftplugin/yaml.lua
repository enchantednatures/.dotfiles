-- if true then vim.cmd [[:set filetype=yaml.docker-compose]] end
local current_file = vim.fn.expand "%"
print(current_file) -- Output: "path/to/file.txt"
if string.find(current_file, "docker", 1, true) and string.find(current_file, "compose", 1, true) then
  local set = vim.opt_local
  set.filetype = "yaml.docker-compose"
end
