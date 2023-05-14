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
