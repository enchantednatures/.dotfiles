# Neovim Configuration

Personal Neovim configuration built with lazy.nvim. Optimized for Go, Rust, C#, TypeScript, and Python development.

## Stats

- **Plugins**: ~100
- **Plugin Manager**: [lazy.nvim](https://github.com/folke/lazy.nvim)
- **Structure**: Modular Lua configuration
- **Size**: ~7MB, ~7,000 lines of Lua

## Quick Start

### Prerequisites

- Neovim 0.10+
- Git
- A [Nerd Font](https://www.nerdfonts.com/) (for icons)
- (Optional) [ripgrep](https://github.com/BurntSushi/ripgrep) for Telescope

### Installation

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.backup

# Clone this config
git clone <your-repo-url> ~/.config/nvim

# Start Neovim (plugins will auto-install)
nvim
```

## Key Features

### Editor

- **File Tree**: nvim-tree.lua (full tree) + oil.nvim (buffer-like editing)
- **Fuzzy Finder**: Telescope with 10+ extensions
- **Statusline**: windline.nvim (airline style)
- **Navigation**: flash.nvim (jump anywhere), eyeliner.nvim (f/F enhancement)
- **Text Objects**: mini.ai + treesitter-textobjects

### Git

- **Signs**: gitsigns.nvim (gutter indicators)
- **UI**: neogit (magit-like) + vim-fugitive (classic commands)
- **Diff**: diffview.nvim (side-by-side diffs)
- **Worktrees**: git-worktree.nvim (switch contexts)

### LSP & Completion

- **LSP Manager**: mason.nvim + nvim-lspconfig
- **Completion**: blink.cmp (modern, fast, Lua-based)
- **Formatting**: conform.nvim (async, multiple formatters)
- **Diagnostics**: none-ls.nvim (code actions + extra linters)

### Languages

| Language | LSP | Special Tools |
|----------|-----|---------------|
| Go | gopls | go.nvim, neotest-golang, dap-go |
| Rust | rust-analyzer | rustaceanvim, crates.nvim |
| C# | roslyn | easy-dotnet.nvim, omnisharp-extended |
| TypeScript | ts_ls | typescript-tools.nvim |
| Python | basedpyright, ruff | neotest-python |

### Testing & Debugging

- **Test Runner**: neotest with adapters for Go, Rust, Python, C#, C++, Plenary
- **Task Runner**: overseer.nvim (build, run, test tasks)
- **Debugger**: nvim-dap with nvim-dap-ui

### AI Integration

- **CodeCompanion**: Multi-provider AI chat (OpenAI, Anthropic, Ollama)
- **Copilot**: GitHub Copilot integration

## Key Mappings (Leader: Space)

### General

| Key | Action |
|-----|--------|
| `<Space>` | Leader key |
| `jk` | Exit insert mode |
| `<leader>w` | Save file |
| `<leader>wa` | Save all files |
| `<leader>e` | Toggle file explorer (nvim-tree) |
| `-` | Open oil.nvim (edit parent directory) |
| `<leader>zz` | Open Lazy (plugin manager) |
| `<C-a>` | Select all |
| `ZZ` | Save all and quit |

### Navigation

| Key | Action |
|-----|--------|
| `<C-j>` / `<C-k>` | Next/previous item (telescope, completion) |
| `<C-u>` / `<C-d>` | Half-page up/down (centered) |
| `n` / `N` | Next/previous search result (centered) |
| `s` | Flash jump (anywhere) |
| `S` | Flash treesitter (select treesitter node) |
| `f` / `F` / `t` / `T` | Eyeliner-enhanced find |

### Git

| Key | Action |
|-----|--------|
| `<leader>gs` | Git status (neogit) |
| `<leader>ghs` | Stage hunk |
| `<leader>ghr` | Reset hunk |
| `<leader>ghp` | Preview hunk |
| `<leader>ghb` | Blame line |
| `<leader>gtb` | Toggle line blame |
| `]c` / `[c` | Next/previous hunk |
| `<leader>gd` | Diff view (index) |
| `<leader>gD` | Diff view (master..HEAD) |
| `<leader>gf` | File history |
| `<leader>tt` | Git worktrees |

### Telescope (Find Anything)

| Key | Action |
|-----|--------|
| `<leader>tf` | Find files (custom function) |
| `<leader><leader>f` | Find files (builtin) |
| `<leader>tg` | Live grep (workspace) |
| `<leader>tw` | Live grep (menufacture) |
| `<leader>tb` | Buffers |
| `<leader>to` | Open buffers |
| `<leader>th` | Help tags |
| `<leader>tp` | Projects |
| `<leader>tr` | Recent files |
| `<leader>td` | Diagnostics (workspace) |
| `<leader>cd` | Diagnostics (document) |
| `<leader>ts` | Workspace symbols |
| `<leader>ta` | Aerial (code outline) |
| `<leader>ty` | Spell suggestions |
| `<leader>tm` | Marks |
| `<leader>t'` | Registers |
| `<leader>U` | Undo history |
| `<leader>kt` | Kafka topics |
| `<leader>tc` | Kubernetes resources (topsail) |
| `<leader><tab>` | Resume last picker |
| `<leader>/` | Fuzzy find in current buffer |

### LSP

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | Find references |
| `gt` | Go to type definition |
| `K` | Hover documentation |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename symbol |
| `<leader>f` | Format document |
| `<leader>cf` | Format (alternative) |
| `<leader>ch` | Signature help |
| `<leader>cd` | Document diagnostics |
| `<leader>cw` | Workspace diagnostics |

### Testing (Neotest)

| Key | Action |
|-----|--------|
| `<leader>Tn` | Run nearest test |
| `<leader>Tf` | Run file tests |
| `<leader>TF` | Debug file |
| `<leader>Tl` | Run last test |
| `<leader>TL` | Debug last test |
| `<leader>TN` | Debug nearest test |
| `<leader>TS` | Toggle test summary |
| `<leader>TO` | Open test output |
| `<leader>Ta` | Attach to test |
| `<leader>Ts` | Stop test |

### Debugging (DAP)

| Key | Action |
|-----|--------|
| `<F5>` | Continue / Start debugging |
| `<F10>` | Step over |
| `<F11>` | Step into |
| `<F12>` | Step out |
| `<leader>b` | Toggle breakpoint |
| `<leader>B` | Conditional breakpoint |
| `<leader>dr` | Open DAP UI |

### Tasks (Overseer)

| Key | Action |
|-----|--------|
| `<leader>or` | Run task |
| `<leader>oo` | Open task list |
| `<leader>ot` | Toggle task list |
| `<leader>ob` | Build |
| `<leader>oc` | Close task list |
| `<leader>oR` | Run command |

### AI (CodeCompanion)

| Key | Action |
|-----|--------|
| `<leader>aa` | Open CodeCompanion |
| `<leader>ac` | Close CodeCompanion |
| `<leader>ae` | Explain code |
| `<leader>af` | Fix code |
| `<leader>at` | Generate tests |
| `<leader>ad` | Generate documentation |

### Window Management

| Key | Action |
|-----|--------|
| `<S-Up>` / `<S-Down>` | Resize window height |
| `<S-Left>` / `<S-Right>` | Resize window width |
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | Navigate windows |
| `<leader>sv` | Source vimrc |
| `<leader>zm` | Zen mode |

### Quickfix

| Key | Action |
|-----|--------|
| `]q` | Next quickfix item |
| `[q` | Previous quickfix item |

### Visual Mode

| Key | Action |
|-----|--------|
| `<` / `>` | Indent and reselect |
| `J` / `K` | Move lines down/up |
| `p` | Paste without yanking |
| `<leader>y` | Yank to system clipboard |
| `<C-a>` / `<C-x>` | Increment/decrement (dial.nvim) |

## Structure

```
~/.config/nvim/
├── init.lua                    # Entry point
├── lazy-lock.json             # Plugin lockfile
├── README.md                  # This file
├── lua/
│   ├── config/               # Core configuration
│   │   ├── init.lua         # Config loader
│   │   ├── lazy.lua         # Plugin manager setup
│   │   ├── options.lua      # Vim options
│   │   ├── keymaps.lua      # Core keymaps
│   │   ├── lsp.lua          # LSP configuration
│   │   ├── lsp_keymaps.lua  # LSP-specific keymaps
│   │   ├── diagnostics.lua  # Diagnostic settings
│   │   ├── colorscheme.lua  # Theme configuration
│   │   ├── icons.lua        # Icon definitions
│   │   ├── format.lua       # Formatting utilities
│   │   └── autocommands/    # Auto-commands
│   │       ├── init.lua
│   │       ├── general.lua
│   │       ├── lsp.lua
│   │       ├── worktree.lua
│   │       └── augroups.lua
│   ├── plugins/             # Plugin configurations
│   │   ├── init.lua        # Core plugins
│   │   ├── ai.lua          # AI plugins (CodeCompanion, Copilot)
│   │   ├── blink.lua       # Completion (blink.cmp)
│   │   ├── lsp.lua         # LSP setup (mason, lspconfig, none-ls, conform)
│   │   ├── treesitter.lua  # Treesitter configuration
│   │   ├── telescope.lua   # Fuzzy finder + extensions
│   │   ├── test.lua        # Testing (neotest, overseer)
│   │   ├── dap.lua         # Debugging
│   │   ├── git-signs.lua   # Git gutter signs
│   │   ├── neogit.lua      # Git UI
│   │   ├── fugitive.lua    # Classic git commands
│   │   ├── diff-view.lua   # Diff viewing
│   │   ├── tree.lua        # File tree (nvim-tree)
│   │   ├── oil.lua         # File editor (oil.nvim)
│   │   ├── mini.lua        # Mini.nvim modules
│   │   ├── noice.lua       # UI enhancements
│   │   ├── whichkey.lua    # Keymap hints
│   │   ├── dashboard.lua   # Startup dashboard
│   │   ├── blink.lua       # Completion
│   │   ├── luasnip.lua     # Snippets
│   │   ├── go.lua          # Go development
│   │   ├── rust.lua        # Rust development
│   │   ├── csharp.lua      # C# development
│   │   ├── typescript.lua  # TypeScript development
│   │   ├── dbee/           # Database client
│   │   ├── octo.lua        # GitHub integration
│   │   └── ...
│   ├── overseer/           # Task templates
│   ├── snippets/           # Custom snippets
│   ├── queries/            # Treesitter queries
│   └── utils/              # Helper functions
│       ├── init.lua
│       ├── diagnostics.lua
│       ├── kubernetes.lua
│       ├── notify.lua
│       ├── overseer.lua
│       ├── platform.lua
│       ├── python.lua
│       ├── rust.lua
│       ├── sops.lua
│       └── worktree.lua
├── after/                  # After-load scripts
├── compiler/               # Compiler definitions
├── lsp/                    # LSP-specific settings
└── spell/                  # Spell files
```

## Customization

### Adding a New Plugin

Create a file in `lua/plugins/`:

```lua
-- lua/plugins/my-plugin.lua
return {
    "author/plugin-name",
    event = "BufReadPre",  -- Lazy load trigger
    config = function()
        require("plugin-name").setup({
            -- your config
        })
    end,
}
```

### Language-Specific Settings

Add to `lua/plugins/` following the pattern of `go.lua` or `rust.lua`:

```lua
-- lua/plugins/my-lang.lua
return {
    {
        "language-server-plugin",
        ft = { "mylang" },  -- Filetype trigger
        config = function()
            -- LSP setup
        end,
    },
    {
        "extra-tool",
        ft = { "mylang" },
        -- more config
    },
}
```

### Custom Keymaps

Add to `lua/config/keymaps.lua`:

```lua
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<leader>xx", "<cmd>MyCommand<cr>", opts)
```

## Troubleshooting

### Plugin not loading?

Check `:Lazy` to see plugin status and any errors.

### LSP not attaching?

1. Check `:LspInfo` to see attached clients
2. Check `:Mason` to ensure server is installed
3. Check filetype with `:set filetype?`

### Keymap conflicts?

Check `:verbose map <key>` to see what's mapped and where.

### Slow startup?

Profile with `:Lazy profile` to see load times.

### Formatting not working?

1. Check `:ConformInfo` for formatter status
2. Ensure formatter is installed (check Mason)
3. Check filetype with `:set filetype?`

## Maintenance

### Updating Plugins

```vim
:Lazy update
```

### Cleaning Unused Plugins

```vim
:Lazy clean
```

### Syncing Lockfile

After updating, commit `lazy-lock.json` to version control.

### Adding New LSP Servers

1. Add to `ensure_installed` in `lua/plugins/lsp.lua`
2. Add any custom configuration if needed
3. Restart Neovim

## Credits

- Plugin manager: [folke/lazy.nvim](https://github.com/folke/lazy.nvim)
- Structure inspired by [LazyVim](https://github.com/LazyVim/LazyVim)
- Icons: [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)

## License

MIT (or your preferred license)
