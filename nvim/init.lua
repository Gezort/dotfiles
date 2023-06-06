-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

-- stylua: ignore start
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'                                                    -- Package manager
  use 'numToStr/Comment.nvim'                                                     -- "gc" to comment visual regions/lines
  use { 'nvim-treesitter/nvim-treesitter', branch='master' }                        -- Highlight, edit, and navigate code
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'master',
    requires = { 'nvim-treesitter/nvim-treesitter' }
  }                                         -- Additional textobjects for treesitter
  use 'ellisonleao/gruvbox.nvim'            -- Gruvbox color scheme
  use 'nvim-lualine/lualine.nvim'           -- Fancier statusline
  use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
  use 'tpope/vim-sleuth'                    -- Detect tabstop and shiftwidth automatically
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } } -- Fuzzy Finder (files, lsp, etc)

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable "make" == 1 }

  use 'nvim-tree/nvim-web-devicons'

  use 'nvim-tree/nvim-tree.lua'

  use 'windwp/nvim-autopairs'              -- Brackets completion
  use 'williamboman/nvim-lsp-installer'   -- Automatically install language servers to stdpath
  use 'neovim/nvim-lspconfig'             -- Collection of configurations for built-in LSP client
  use {
    'nvim-lua/lsp-status.nvim',           -- Status line for LSP
    config = function ()
      require('lsp-status').register_progress()
    end
  }
  -- Autocompletion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip',
    }
  }

  if is_bootstrap then
    require('packer').sync()
  end
end)
-- stylua: ignore end

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})

--[[
==========================================
=====_____===========================_ ===
====/ ____|=========================| |===
===| |  __  ___ _ __   ___ _ __ __ _| |===
===| | |_ |/ _ \ '_ \ / _ \ '__/ _` | |===
===| |__| |  __/ | | |  __/ | | (_| | |===
====\_____|\___|_| |_|\___|_|  \__,_|_|===
==========================================
==========================================
--]]

require 'mappings'
require 'common'

--[[
========================================
=== _____  _=============_==============
===|  __ \| |===========(_)=============
===| |__) | |_   _  __ _ _ _ __  ___ ===
===|  ___/| | | | |/ _` | | '_ \/ __|===
===| |    | | |_| | (_| | | | | \__ \===
===|_|    |_|\__,_|\__, |_|_| |_|___/===
====================__/ |===============
===================|___/ ===============
========================================
--]]

require 'plugins.nvim_tree'
require 'plugins.colorscheme'
require 'plugins.lualine'
require 'plugins.comment_nvim'
require 'plugins.indent'
require 'plugins.telescope'
require 'plugins.treesitter'
require 'plugins.autopairs'

--[[
============================
====_       _____ _____=====
===| |     / ____|  __ \====
===| |    | (___ | |__) |===
===| |     \___ \|  ___/====
===| |____ ____) | |========
===|______|_____/|_|========
============================
==========================================
--]]

require 'lsp.lsp'
require 'lsp.nvim_cmp'

-- -- The line beneath this is called `modeline`. See `:help modeline`
-- -- vim: ts=2 sts=2 sw=2 et
