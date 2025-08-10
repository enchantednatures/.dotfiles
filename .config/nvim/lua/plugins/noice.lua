return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    -- {
    --   "rcarriga/nvim-notify",
    --   lazy = true,
    --   opts = {
    --     timeout = 3000,
    --     background_colour = "#000000",
    --     max_height = function() return math.floor(vim.o.lines * 0.25) end,
    --     max_width = function() return math.floor(vim.o.columns * 0.25) end,
    --   },
    --   config = function(_, opts)
    --     require("notify").setup(opts)
    --     vim.notify = require "notify"
    --   end,
    -- },
  },
  event = "VeryLazy",
  -- lazy = true,
  config = true,
  opts = {
    popupmenu = {
      -- cmp-cmdline has more sources and can be extended
      backend = "cmp", -- backend to use to show regular cmdline completions
    },
    notify = {
      -- only show one notification at a time
      max_width = 60,
      max_height = 10,
      replace = true, -- Replace existing notifications with new ones
      merge = true, -- Merge notifications with the same title
      max_visible = 1, -- Only show 1 notification at a time
    },
    views = {
      cmdline_popup = {
        size = {
          width = 60,
          height = "auto",
          max_height = 15,
        },
      },
      hover = {
        size = {
          max_width = 60,
          max_height = 15,
        },
      },
      popup = {
        size = {
          max_width = 60,
          max_height = 15,
        },
      },
    },
    messages = {
      -- Using kevinhwang91/nvim-hlslens because virtualtext is hard to read
      view_search = false,
    },
    lsp = {
      progress = {
        enabled = true,
      },
      hover = { enabled = true },
      signature = { enabled = false },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        -- ["cmp.entry.get_documentation"] = true,
      },
    },
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = true, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
    routes = {
      { filter = { find = "E162" }, view = "mini" },
      { filter = { event = "msg_show", kind = "", find = "written" }, view = "mini" },
      { filter = { event = "msg_show", find = "search hit BOTTOM" }, skip = true },
      { filter = { event = "msg_show", find = "search hit TOP" }, skip = true },
      { filter = { event = "emsg", find = "E23" }, skip = true },
      { filter = { event = "emsg", find = "E20" }, skip = true },
      { filter = { find = "No signature help" }, skip = true },
      { filter = { find = "E37" }, skip = true },
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "written",
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "notify",
          find = "Multiple potential target files found",
        },
        opts = { skip = true },
      },
      { -- send annoying msgs to mini
        filter = {
          event = "msg_show",
          any = {
            { find = "; after #%d+" },
            { find = "; before #%d+" },
            { find = "fewer lines" },
          },
        },
        view = "mini",
      },
    },
  },
  --stylua: ignore
  keys = {
    {
      "<S-Enter>",
      function() require("noice").redirect(vim.fn.getcmdline()) end,
      mode = "c",
      desc = "Redirect Cmdline"
    },
    {
      "T",
      function() require("noice").dismiss() end,
      mode = "n",
      desc = "Clear"
    },
    {
      "<leader>snl",
      function() require("noice").cmd("last") end,
      desc = "Noice Last Message"
    },
    {
      "<leader>snh",
      function() require("noice").cmd("history") end,
      desc = "Noice History"
    },
    {
      "<leader>sna",
      function() require("noice").cmd("all") end,
      desc = "Noice All"
    },
    {
      "<c-f>",
      function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,
      silent = true,
      expr = true,
      desc = "Scroll forward"
    },
    {
      "<c-b>",
      function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end,
      silent = true,
      expr = true,
      desc = "Scroll backward"
    },
  },
}
