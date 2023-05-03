-- Set / as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = '/'
vim.g.maplocalleader = '/'

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Disable arrow navigation
vim.keymap.set({'n', 'v'}, '<Left>', ':echoe "Use h"<CR>')
vim.keymap.set({'n', 'v'}, '<Right>', ':echoe "Use l"<CR>')
vim.keymap.set({'n', 'v'}, '<Up>', ':echoe "Use k"<CR>')
vim.keymap.set({'n', 'v'}, '<Down>', ':echoe "Use j"<CR>')
