local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

return {
  s(
    "req",
    fmt([[local {} = require "{}"]], {
      f(function(import_name)
        local parts = vim.split(import_name[1][1], ".", true)
        return parts[#parts] or ""
      end, { 1 }),
      i(1),
    })
  ),
  s("oldreq", fmt("local {} = require('{}')", { i(1, "default"), rep(1) })),
  s("lf", fmt("local {} = function({})\n    {}\nend", { i(1), i(2), i(0) })),
}
