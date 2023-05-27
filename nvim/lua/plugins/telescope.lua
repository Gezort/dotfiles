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

-- Bindings

local tbuiltin = require('telescope.builtin')
local get_file_search_dir = function ()
  local cur_dir = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
  local depth = 1
  for dir in vim.fs.parents(cur_dir) do
    if dir == vim.loop.os_homedir() then
      break
    else
      depth = depth + 1
    end
  end
  if depth < 4 then
    return cur_dir
  else
    return cur_dir .. string.rep("/..", depth - 3)
  end
end

local search_files = function ()
  return tbuiltin.find_files({cwd=get_file_search_dir()})
end

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', tbuiltin.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', tbuiltin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>sf', search_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').live_grep, { desc = '[S]earch word by [G]rep' })

vim.keymap.set('n', '<leader>sch', require('telescope.builtin').command_history, { desc = '[S]earch in [C]ommand [H]istory' })
