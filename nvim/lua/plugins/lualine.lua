-- Set lualine as statusline
-- See `:help lualine.txt`
local lualine_custom_theme = require 'lualine.themes.wombat'
lualine_custom_theme.normal.c.bg = '#703dc8'
lualine_custom_theme.visual.a.bg = 'orange'
local lsp_status = require('lsp-status')
function get_lsp_progress()
  local spinner_frames = {'⣷', '⣯', '⣟', '⡿', '⢿', '⣻', '⣾', '⣽'}
  local messages = lsp_status.messages()
  local content = {}
  for _, msg in ipairs(messages) do
    local output = ''
    if msg.progress then
      output = output..msg.title
      if msg.percentage then
        output = output .. ' (' .. math.floor(msg.percentage + 0.5) .. '%%)'
      end
      if msg.spinner then
        output = spinner_frames[(msg.spinner % #spinner_frames) + 1] .. ' ' .. output
      end
    end
    if content[msg.name] == nil then
      content[msg.name] = output
    else
      content[msg.name] = content[msg.name] .. ', ' .. output
    end
  end

  local output = ''
  for k,v in pairs(content) do
    if #output > 0 then
      output = ' | ' .. output
    end
    output = output .. 'buf.' .. k .. ': ' .. v
  end
  return output
end
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = lualine_custom_theme,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    refresh = { statusline = 500 },
    globalstatus = true,
  },
  sections = {
    lualine_c = { 'filename', get_lsp_progress },
  }
}
