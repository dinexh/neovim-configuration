vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = false

vim.o.number = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.cursorline = true
vim.o.scrolloff = 8

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>')
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<CR>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>')

-- Lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git','clone','--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

  { 'folke/tokyonight.nvim', priority = 1000,
    config = function()
      vim.cmd.colorscheme 'tokyonight-night'
    end
  },

  { 'nvim-tree/nvim-web-devicons' },

  { 'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup { options = { theme = 'tokyonight' } }
    end
  },

  { 'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup({})
    end
  },

  { 'nvim-lua/plenary.nvim' },

  { 'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup({})
    end
  },

  { 'lewis6991/gitsigns.nvim', opts = {} },

  { 'folke/which-key.nvim', event = 'VimEnter', opts = {} },

  -- ✅ TREESITTER (GUARDED, WILL NOT CRASH)
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      local ok, ts = pcall(require, 'nvim-treesitter.configs')
      if not ok then
        vim.notify('Treesitter not loaded, skipping setup', vim.log.levels.WARN)
        return
      end
      ts.setup {
        ensure_installed = { 'lua', 'python', 'javascript', 'html', 'css', 'bash' },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      }
    end,
  },

  { 'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'saghen/blink.cmp',
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local servers = { pyright = {}, lua_ls = {} }

      require('mason-tool-installer').setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      require('mason-lspconfig').setup {
        handlers = {
          function(server)
            require('lspconfig')[server].setup {
              capabilities = capabilities,
            }
          end,
        },
      }
    end,
  },

  { 'saghen/blink.cmp',
    version = '1.*',
    event = 'InsertEnter',
    dependencies = { 'L3MON4D3/LuaSnip' },
    opts = {
      sources = { default = { 'lsp', 'path', 'snippets' } },
      fuzzy = { implementation = 'lua' },
    }
  },

}, {})

