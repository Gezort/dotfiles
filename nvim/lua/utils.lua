local M = {}

local function dump_inner(o, depth)
  local function get_padding(depth)
    local pad = ''
    for _ = 1, depth do
      pad = '  ' .. pad
    end
    return pad
  end

  if type(o) == 'table' then
    local s = '{\n'
    for k,v in pairs(o) do
      if type(k) ~= 'number' then k = '"'..k..'"' end
      s = s .. get_padding(depth + 1) .. '['..k..'] = ' .. dump_inner(v, depth + 1)
    end
    return s .. '\n' .. get_padding(depth) .. '},\n'
  else
    return tostring(o) .. ','
  end
end

M.dump = function(o)
  return dump_inner(o, 0)
end

return M
