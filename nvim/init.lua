-- Install packer
-- Uncomment this for debugging
utils = require('utils')
-- use: lua print(utils.dump(...))

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



  use 'jiangmiao/auto-pairs'              -- Brackets completion
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

-- TODO: fix diagnostic
vim.diagnostic.config {
    signs = false,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    virtual_text = {
      spacing = 4,
      source = 'if_many',
      prefix = ' ',
    },
}
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

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

-- Configure nerdtree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local api = require('nvim-tree.api')
local opts = { expr = false, noremap = true, silent = true }
local ntree_onattach = function (bufnr)
  vim.keymap.set('n', 's', api.node.open.vertical, opts)
  vim.keymap.set('n', '<CR>', api.node.open.edit, opts)
end
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  renderer = {
      group_empty = true,
      root_folder_label = ":t:s?$?/..?"
  },
  filters = {
      dotfiles = true,
  },
  on_attach = ntree_onattach,
  update_focused_file = {
    enable = true,
    update_root = true,
  },
  view = {
    width = {
      min = 10,
      max = 40,
    },
  },
})
vim.keymap.set('n', '<C-n>', api.tree.toggle, opts)


-- Set colorscheme
require('gruvbox').setup {
  contrast = 'hard'
}
vim.o.termguicolors = true
vim.cmd('highlight DiagnosticVirtualTextWarn guibg=#ffd166')
vim.o.background = 'dark'
vim.cmd('colorscheme gruvbox')



-- Set lualine as statusline
-- See `:help lualine.txt`
local lualine_custom_theme = require 'lualine.themes.wombat'
lualine_custom_theme.normal.c.bg = '#703dc8'
lualine_custom_theme.visual.a.bg = 'orange'
local lsp_status = require('lsp-status')
function get_lsp_progress()
  local spinner_frames = {'⣷', '⣯', '⣟', '⡿', '⢿', '⣻', '⣾', '⣽'}
  local messages = lsp_status.messages()
  local content = {}
  for _, msg in ipairs(messages) do
    local output = ''
    if msg.progress then
      output = output..msg.title
      if msg.percentage then
        output = output .. ' (' .. math.floor(msg.percentage + 0.5) .. '%%)'
      end
      if msg.spinner then
        output = spinner_frames[(msg.spinner % #spinner_frames) + 1] .. ' ' .. output
      end
    end
    if content[msg.name] == nil then
      content[msg.name] = output
    else
      content[msg.name] = content[msg.name] .. ', ' .. output
    end
  end

  local output = ''
  for k,v in pairs(content) do
    if #output > 0 then
      output = ' | ' .. output
    end
    output = output .. 'buf.' .. k .. ': ' .. v
  end
  return output
end
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = lualine_custom_theme,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    refresh = { statusline = 500 },
    globalstatus = true,
  },
  sections = {
    lualine_c = { 'filename', get_lsp_progress },
  }
}


-- Enable Comment.nvim
require('Comment').setup {
  toggler = {
    line = '<leader>cc',
    block = '<leader>cb'
  },
  opleader = {
    line = '<leader>cc',
    block = '<leader>cb'
  },
  ignore = '^(%s*)$',
}


-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
require('indent_blankline').setup {
  char = '┊',
  show_trailing_blankline_indent = true,
  show_first_indent_level = false,
  show_current_context = true,
  show_current_context_start = true,
}
vim.opt.list = true
vim.opt.listchars:append "trail:⋅"


-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    layout_config = {
      horizontal = {
        width = 0.7
      }
    },
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ['<C-h>'] = 'which_key',            -- show key mappings in normal mode
        ['<C-x>'] = false,
        ['<C-_>'] = false,
        ['<PageUp>'] = false,
        ['<PageDown>'] = false,
        ['jj'] = require('telescope.actions').results_scrolling_down,
        ['kk'] = require('telescope.actions').results_scrolling_up,
        ['<esc>'] = require('telescope.actions').close,
      },
      n = {
        ['<C-h>'] = 'which_key',            -- show key mappings in normal mode
        ['<C-x>'] = false,
        ['jj'] = require('telescope.actions').results_scrolling_down,
        ['kk'] = require('telescope.actions').results_scrolling_up,
      },
    },
    pickers = {
    },
    extensions = {
    }
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').live_grep, { desc = '[S]earch word by [G]rep' })

vim.keymap.set('n', '<leader>ch', require('telescope.builtin').command_history, { desc = 'Search in [C]ommand [H]istory' })


-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'lua', 'rust', 'go', 'python', 'cpp', 'bash', 'json' },
  highlight = { enable = true },
  indent = { enable = false },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      node_decremental = '<S-space>',
    },
  },
}
vim.opt.foldmethod = "expr"
vim.opt.foldlevelstart = 999
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- Don't fold text
vim.opt.conceallevel = 0

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

--  This function gets run when an LSP connects to a particular buffer.
local lsp_on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
  nmap('gs', '<cmd>ClangdSwitchSourceHeader<CR>', '[G]o [S]ource')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation ([K]eyword)')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
end

-- Enable the following language servers
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('nvim-lsp-installer').setup {
  ensure_installed = { 'clangd', 'lua_ls' },
}

lspconfig.clangd.setup {
  cmd = {
    'clangd',
    '--background-index',
    '-j=8',
    '--header-insertion=never',
    '--log=verbose',
  },
  log_level = vim.lsp.protocol.MessageType.Log,
  highlight = { enable = true, lsRanges = true },
  filetypes = { 'h', 'hh', 'hpp', 'c', 'cc', 'cpp', 'objc', 'objcpp' },
  on_attach = lsp_on_attach,
  init_options = { clangdFileStatus = true },
  capabilities = capabilities,

}

lspconfig.lua_ls.setup {
  on_attach = lsp_on_attach,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT)
        version = 'LuaJIT',
        -- version = 'Lua 5.4.4',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        enable = true,
        globals = { 'vim', 'describe', 'it', 'before_each', 'after_each' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
      completion = { enable = true, },
    },
  },
}

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
}

-- close `quickfix` and `help` buffers on <CR> or <C-w>
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    local bufnr = vim.fn.bufnr('%')
    for _, key in ipairs({ "<CR>", "<C-w>" }) do
      vim.keymap.set("n", key, function()
        vim.api.nvim_command([[execute "normal! \<cr>"]])
        vim.api.nvim_command(bufnr .. 'bd')
      end, { buffer = bufnr })
    end
  end,
  pattern = "qf,help",
})


-- -- The line beneath this is called `modeline`. See `:help modeline`
-- -- vim: ts=2 sts=2 sw=2 et
