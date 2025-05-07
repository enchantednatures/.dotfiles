return {
  {
    "ray-x/go.nvim",
    ft = { "go", "gomod", "gowork", "gotmpl" },
    dependencies = {
      "ray-x/guihua.lua",
      -- "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest",
      "nvim-neotest/neotest-go",
    },
    build = ':lua require("go.install").update_all_sync()',
    lazy = true,
    -- event = { "CmdlineEnter" },
    config = function()
      -- Fix neotest-go test detection
      local neotest = require "neotest"

      -- Ensure the delve debugger is properly configured for Go tests
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "go",
        callback = function()
          -- Set DAP configurations for Go
          require("dap.ext.vscode").load_launchjs(nil, {
            delve = { "go" },
          })
        end,
      })

      require("go").setup {
        disable_defaults = false,
        go = "go", -- binary name, can be go[default] or go1.18beta1
        goimports = "gopls", -- use gopls for imports
        fillstruct = "gopls",
        gofmt = "gofumpt", -- gofmt cmd
        tag_transform = false, -- tag_transfer  check gomodifytags for details
        test_template = "", -- default to testify if not set; g:go_nvim_tests_template  check gotests for details
        test_template_dir = "", -- default to nil if not set; g:go_nvim_tests_template_dir  check gotests for details
        comment_placeholder = "", -- comment_placeholder your cool placeholder e.g. ﳑ
        icons = { breakpoint = "🧘", currentpos = "🏃" },
        verbose = false, -- output loginf in messages
        lsp_cfg = true, -- true: use non-default gopls setup specified in go/lsp.lua
        lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
        lsp_on_attach = true, -- if a on_attach function provided:  attach on_attach function to gopls
        lsp_keymaps = false, -- set to false to disable gopls/lsp keymap
        lsp_codelens = true, -- set to false to disable codelens, true by default, you can use a function

        -- Updated diagnostic settings
        diagnostic = {
          hdlr = true, -- hook lsp diagnostic handler
          virtual_text = { space = 0, prefix = "" },
          signs = true,
          update_in_insert = true,
        },

        lsp_document_formatting = true,
        -- set to true: use gopls to format
        -- false if you want to use other formatter tool(e.g. efm, nulls)
        gopls_cmd = nil, -- if you need to specify gopls path and cmd, e.g. cmd = {"/home/user/lsp/gopls", "-logfile", "/var/log/gopls.log" }
        gopls_remote_auto = true, -- add -remote=auto to gopls
        dap_debug = true, -- set to false to disable dap
        dap_debug_keymap = true, -- true: use keymap for debugger defined in go/dap.lua
        -- false: do not use keymap in go/dap.lua.  you must define your own.
        -- Windows: Use Visual Studio keymap
        dap_debug_gui = true, -- set to true to enable dap gui, highly recommend
        dap_debug_vt = true, -- set to true to enable dap virtual text
        build_tags = "", -- set default build tags
        textobjects = true, -- enable default text objects through treesittter-text-objects
        test_runner = "go", -- one of {`go`, `richgo`, `dlv`, `ginkgo`, `gotestsum`}
        verbose_tests = true, -- set to add verbose flag to tests
        run_in_floaterm = false, -- set to true to run in float window. :GoTermClose closes the floatterm
        -- float term recommend if you use richgo/ginkgo with terminal color
        trouble = false, -- true: use trouble to open quickfix
        test_efm = false, -- errorformat for quickfix
        luasnip = false, -- enable included luasnip snippets. you can also disable while add your own.
      }
    end,
  },
}
