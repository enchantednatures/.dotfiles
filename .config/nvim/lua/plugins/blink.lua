return {
  "saghen/blink.cmp",
  version = "1.*",
  dependencies = {
    "fang2hou/blink-copilot",
    opts = {
      max_completions = 3, -- Global default for max completions
      max_attempts = 2, -- Global default for max attempts
    },
  },
  opts = {
    signature = { enabled = true },

    enabled = function()
      return not vim.tbl_contains({
        "NvimTree",
        "Telescope",
        "DressingInput",
        "TelescopePrompt",
      }, vim.bo.filetype) and vim.bo.buftype ~= "prompt" and vim.b.completion ~= false
    end,
    cmdline = {
      keymap = {
        ["<Tab>"] = { "select_and_accept", "select_next" },
        -- ["<Shift-Tab>"] = {},
        ["<CR>"] = { "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
      },
      -- (optionally) automatically show the menu
      completion = {
        menu = { auto_show = true },
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
      ["C-space>"] = { "show", "show_documentation", "hide_documentation", "hide" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        "snippet_forward",
        "fallback",
      },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
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
        show_with_menu = true,
        show_without_menu = true,
      },
    },
    snippets = { preset = "luasnip" },
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "omni", "lazydev", "copilot" },
      per_filetype = {
        codecompanion = { "codecompanion" },
      },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
          opts = {
            max_completions = 3,
          },
        },
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
