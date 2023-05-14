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
