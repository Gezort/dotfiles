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
