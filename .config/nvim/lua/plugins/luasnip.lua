return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  event = { "VeryLazy", "InsertEnter" },
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  build = "make install_jsregexp",
  opts = {
    history = true,
    delete_check_events = "TextChanged",
  },
  keys = {
    {
      "<c-u>",
      function() require "luasnip.extras.select_choice"() end,
      mode = "i",
      desc = "select_choice",
    },
  },
  config = function()
    local ls = require "luasnip"
    local types = require "luasnip.util.types"
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip").filetype_extend("typescript", { "tsdoc" })
    require("luasnip").filetype_extend("javascript", { "jsdoc" })
    require("luasnip").filetype_extend("lua", { "luadoc" })
    require("luasnip").filetype_extend("python", { "pydoc" })
    require("luasnip").filetype_extend("rust", { "rustdoc" })
    require("luasnip").filetype_extend("cs", { "csharpdoc" })
    require("luasnip").filetype_extend("csharp", { "csharpdoc" })
    require("luasnip").filetype_extend("java", { "javadoc" })
    require("luasnip").filetype_extend("c", { "cdoc" })
    require("luasnip").filetype_extend("cpp", { "cppdoc" })
    require("luasnip").filetype_extend("php", { "phpdoc" })
    require("luasnip").filetype_extend("kotlin", { "kdoc" })
    require("luasnip").filetype_extend("ruby", { "rdoc" })
    require("luasnip").filetype_extend("sh", { "shelldoc" })

    local lua = require "luasnip.loaders.from_lua"
    lua.load { paths = os.getenv "HOME" .. "/.config/nvim/snippets/" }

    ls.config.set_config {
      history = true,
      updateevents = "TextChanged,TextChangedI",
      region_check_events = "InsertEnter,CursorMoved",
      delete_check_events = "TextChanged,InsertLeave",
      enable_autosnippets = true,
      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { "●", "PortalOrange" } },
            hl_mode = "combine",
          },
        },
        [types.insertNode] = {
          active = {
            virt_text = { { "●", "PortalBlue" } },
            hl_mode = "combine",
          },
        },
      },
    }

    local s, i, t, c, f, d, sn =
      ls.s, ls.insert_node, ls.text_node, ls.choice_node, ls.function_node, ls.dynamic_node, ls.sn
    ls.add_snippets(nil, {
      all = {
        s("todo", {
          c(1, {
            t "TODO(hcasten): ",
            t "FIX(hcasten): ",
            t "NOTE(hcasten): ",
            t "TODO(anybody please help me): ",
          }),
        }),
      },
    })
  end,
}
