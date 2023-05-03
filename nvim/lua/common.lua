-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Set highlight on search
vim.o.hlsearch = true

-- highlight cur line
vim.opt.cursorline = true

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.opt.spell = true
vim.opt.spelllang = 'en'
vim.opt.spelloptions = 'camel'

-- Open file on the same line
vim.api.nvim_create_autocmd(
  "BufUnload",
  {pattern = '*', command = 'silent! mkview'}
)
vim.api.nvim_create_autocmd(
  "BufRead",
  {pattern = '*', command = 'silent! loadview'}
)

-- remove trailing spaces
vim.api.nvim_create_autocmd(
  "BufWritePre",
  {pattern = "*", command = '%s/\\s\\+$//e'}
)

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
