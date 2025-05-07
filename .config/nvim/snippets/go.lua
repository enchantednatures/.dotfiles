local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

return {
  -- handle errors
  s(
    "iferr",
    fmt(
      [[
                        if err != nil {{
                            log.Fatalf("Error: %v", err)
                        }}
                        {}
                        ]],
      {
        i(0),
      }
    )
  ),

  s(
    "range",
    fmt(
      [[
                        for _, {} := range {} {{
                            {}
                        }}
                        ]],
      {
        i(1),
        i(2),
        i(0),
      }
    )
  ),

  s(
    "gofunc",
    fmt(
      [[
                        var wg = &sync.WaitGroup{{}}
                        for _, {} := range {} {{
                            wg.Add(1)
                            go func ({} {}) {{
                                {}
                                wg.Done()
                            }}({})
                        }}
                        wg.Wait()
                        ]],
      {
        i(1),
        i(2),
        rep(1),
        i(3),
        i(0),
        rep(1),
      }
    )
  ),

  -- print the contents of a variable
  s("print", fmt([[ log.Printf("{} = %v", {}) ]], { i(1, "variable_name"), rep(1) })),
}
