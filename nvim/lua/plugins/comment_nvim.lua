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
