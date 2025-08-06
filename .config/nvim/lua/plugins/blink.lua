return {
  "saghen/blink.cmp",
  version = "1.*",
  opts = {
    signature = { enabled = true },

    enabled = function()
      local disabled_ft = {
        "NvimTree",
        "Telescope",
        "DressingInput",
        "TelescopePrompt",
      }
      return not vim.tbl_contains(disabled_ft, vim.bo.filetype)
        and vim.bo.buftype ~= "prompt"
        and vim.b.completion ~= false
    end,

    cmdline = {
      keymap = {
        ["<Tab>"] = { "select_and_accept", "select_next" },
        -- ["<Shift-Tab>"] = {},
        ["<CR>"] = { "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
      },
      completion = {
        ghost_text = {
          enabled = true,
        },
        menu = {
          auto_show = true,
        },
        list = {
          selection = {
            preselect = false,
            auto_insert = true,
          },
        },
      },
    },
    keymap = {
      preset = "default",
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation", "hide" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = {
        function(cmp)
          local luasnip = require "luasnip"
          if cmp.snippet_active() then
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
              return
            else
              return cmp.accept()
            end
          else
            return cmp.select_and_accept()
          end
        end,
        "snippet_forward",
        "fallback",
      },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
      ["ESC"] = {
        function(cmp)
          if cmp.snippet_active() then return cmp.cancel() end
          return cmp.hide()
        end,
      },
    },

    appearance = {
      nerd_font_variant = "Nerd Font Mono",
      kind_icons = {
        Text = "󰉿",
        Method = "󰊕",
        Function = "󰊕",
        Constructor = "󰒓",

        Field = "󰜢",
        Variable = "󰆦",
        Property = "󰖷",

        Class = "󱡠",
        Interface = "󱡠",
        Struct = "󱡠",
        Module = "󰅩",

        Unit = "󰪚",
        Value = "󰦨",
        Enum = "󰦨",
        EnumMember = "󰦨",

        Keyword = "󰻾",
        Constant = "󰏿",

        Snippet = "󱄽",
        Color = "󰏘",
        File = "󰈔",
        Reference = "󰬲",
        Folder = "󰉋",
        Event = "󱐋",
        Operator = "󰪚",
        TypeParameter = "󰬛",
        claude = "󰋦",
        openai = "󱢆",
        codestral = "󱎥",
        gemini = "",
        Groq = "",
        Openrouter = "󱂇",
        Ollama = "󰳆",
        ["Llama.cpp"] = "󰳆",
        Deepseek = "",
      },
    },
    completion = {
      keyword = { range = "full" },
      list = {
        selection = {
          preselect = true,
          auto_insert = true,
        },
      },
      trigger = {
        show_on_trigger_character = true,
        show_on_keyword = true,
        prefetch_on_insert = false,
      },
      menu = {
        auto_show = true,
        draw = {
          columns = {
            { "label", "label_description", gap = 1 },
            { "source_name", "kind_icon", gap = 2 },
          },
        },
      },
      documentation = { auto_show = true, auto_show_delay_ms = 50 },
      -- Displays a preview of the selected item on the current line
      ghost_text = {
        enabled = true,
        show_with_selection = true,
        show_without_selection = false,
        show_with_menu = false,
        show_without_menu = true,
      },
    },
    snippets = { preset = "luasnip" },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      per_filetype = {
        codecompanion = { "codecompanion" },
      },
      providers = {
        path = {
          min_keyword_length = 2,
          score_offset = -10,
        },
        buffer = {
          min_keyword_length = 3,
          score_offset = -10,
        },
        snippets = {
          min_keyword_length = 3,
        },
      },
    },
    fuzzy = { implementation = "rust" },
  },
  opts_extend = { "sources.default" },
}
