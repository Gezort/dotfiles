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
