vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

local o = vim.o
o.number = true
o.mouse = 'a'
o.showmode = false
o.breakindent = true
o.undofile = true
o.ignorecase = true
o.smartcase = true
o.signcolumn = 'yes'
o.updatetime = 250
o.timeoutlen = 300
o.splitright = true
o.splitbelow = true
o.cursorline = true
o.scrolloff = 8

vim.schedule(function() o.clipboard = 'unnamedplus' end)

local map = vim.keymap.set
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = 'File explorer' })
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { desc = 'Find files' })
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { desc = 'Live grep' })
map('n', '<S-h>', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })
map('n', '<S-l>', '<cmd>bnext<CR>', { desc = 'Next buffer' })
map('n', '<leader>bd', '<cmd>bdelete<CR>', { desc = 'Delete buffer' })
map('n', '<leader>bl', '<cmd>Telescope buffers<CR>', { desc = 'List buffers' })

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({ 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', lazypath })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

  { 'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false,
    priority = 1000,
    config = function()
      require('github-theme').setup({})
      vim.cmd.colorscheme('github_dark_default')
    end,
  },

  { 'nvim-tree/nvim-web-devicons', lazy = true },

  { 'nvim-lualine/lualine.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = { options = { theme = 'auto' } },
  },

  { 'nvim-tree/nvim-tree.lua',
    dependencies = 'nvim-tree/nvim-web-devicons',
    cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
    opts = {},
  },

  { 'nvim-telescope/telescope.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    cmd = 'Telescope',
    opts = {},
  },

  { 'lewis6991/gitsigns.nvim', event = 'BufReadPre', opts = {} },

  { 'folke/which-key.nvim', event = 'VimEnter', opts = {} },

  { 'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'BufReadPost',
    opts = {
      ensure_installed = { 'lua', 'python', 'javascript', 'typescript', 'html', 'css', 'bash' },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
  },

  { 'windwp/nvim-autopairs', event = 'InsertEnter', opts = {} },

  { 'neovim/nvim-lspconfig',
    event = 'BufReadPre',
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
            require('lspconfig')[server].setup { capabilities = capabilities }
          end,
        },
      }
    end,
  },

  { 'saghen/blink.cmp',
    version = '1.*',
    dependencies = 'L3MON4D3/LuaSnip',
    opts = {
      sources = { default = { 'lsp', 'path', 'snippets' } },
      fuzzy = { implementation = 'lua' },
    },
  },

})
