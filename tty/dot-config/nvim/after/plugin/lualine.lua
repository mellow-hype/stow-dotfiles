
-- init for lualine
local custom_selectioncount = function()
  local mode = vim.fn.mode()
  -- exit if not in a visual/selection mode
  if mode ~= "v" and mode ~= "V" and mode ~= "\22" then
    return ""
  end
  local wc = vim.fn.wordcount()
  local chars = wc.visual_chars
  if chars == nil then
    return ""
  end
  return tostring(chars)
end


require('lualine').setup{
  options = {
    theme = 'auto',
  },
  sections = {
    -- path=4 means parent/filename format
    lualine_c = {
      { 'filename', path = 4 },
    },
    -- right side ------------
    lualine_x = {
      'encoding',
      {
        'fileformat',
        symbols = { unix = 'unix', dos = 'dos', mac = 'mac' }
      },
      'filetype',
    },
    lualine_y = {
      { custom_selectioncount }
    },
    lualine_z = {
      {'location'},
    },
  },
  inactive_sections = {
    lualine_c = {{ 'filename', path = 4 }},
    lualine_x = {'location'},
  },
  tabline = {
    lualine_a = { 'buffers' },
    lualine_z = { 'tabs' },
  },
}

