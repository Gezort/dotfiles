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
