local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

return {
  s(
    "varexists",
    fmt(
      [[
                        if [ -z ${} ]; then
                            echo "Please set the {} env var in your shell"
                            exit 1
                        fi
                        ]],
      {
        i(1, "ENV_VAR_NAME"),
        rep(1),
      }
    )
  ),
}
