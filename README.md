# My Neovim Config

Single-file Neovim setup using [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager.

## Keybindings

Leader key: `Space`

### General

| Key | Action |
|-----|--------|
| `<Esc>` | Clear search highlight |
| `<leader>e` | Toggle file explorer |

### Search (Telescope)

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search text) |
| `<leader>bl` | List open buffers |

### Buffers

| Key | Action |
|-----|--------|
| `Shift+H` | Previous buffer |
| `Shift+L` | Next buffer |
| `<leader>bd` | Close buffer |

## Plugins

| Plugin | Purpose |
|--------|---------|
| github-nvim-theme | Colorscheme (github_dark_default) |
| nvim-web-devicons | File icons |
| lualine.nvim | Status line |
| nvim-tree.lua | File explorer |
| telescope.nvim | Fuzzy finder |
| gitsigns.nvim | Git signs in gutter |
| which-key.nvim | Keybinding popup helper |
| nvim-treesitter | Syntax highlighting |
| nvim-autopairs | Auto-close brackets/quotes |
| nvim-lspconfig | LSP client (pyright, lua_ls) |
| mason.nvim | LSP/tool installer |
| blink.cmp | Autocompletion (LSP, path, snippets) |
| LuaSnip | Snippet engine |

## LSP Servers

- **pyright** -- Python
- **lua_ls** -- Lua

Installed automatically via Mason on first launch.

## Requirements

- Neovim >= 0.10
- A Nerd Font set as the non-ASCII/fallback font in your terminal (for icons)
- Git
