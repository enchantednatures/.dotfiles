return {
  "3rd/diagram.nvim",
  dependencies = {
    {
      "3rd/image.nvim",
      opts = {
        backend = "kitty", -- Kitty image protocol works for Kitty, WezTerm, and Ghostty
        processor = "magick_cli",
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { "markdown", "vimwiki" },
          },
        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = nil,
        max_height_window_percentage = 50,
      },
    },
  },
  opts = {
    renderer_options = {
      mermaid = {
        theme = "dark", -- Default theme
        -- cli_args = { "--no-sandbox" },
      },
    },
  },
  keys = {
    {
      "<leader>md",
      function() require("diagram").show_diagram_hover() end,
      mode = "n",
      ft = { "markdown", "norg" },
      desc = "Show diagram in new tab",
    },
  },
}
