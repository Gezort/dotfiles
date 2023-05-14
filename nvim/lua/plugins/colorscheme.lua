require('gruvbox').setup {
  contrast = 'hard'
}
vim.o.termguicolors = true
vim.cmd('highlight DiagnosticVirtualTextWarn guibg=#ffd166')
vim.o.background = 'dark'
vim.cmd('colorscheme gruvbox')
