-- init for lualine

require('lualine').setup{
  options = {
    theme = 'base16',
  },
  sections = {
    -- path=4 means parent/filename format
    lualine_c = {
      { 'filename', path = 4 },
    },
    lualine_x = {
      'filetype',
      'encoding',
      {
        'fileformat',
        symbols = { unix = 'unix', dos = 'dos', mac = 'mac' }
      },
    },
    lualine_y = {},
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

