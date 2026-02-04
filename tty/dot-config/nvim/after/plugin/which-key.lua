
local wk = require('which-key')

-- add specific groups with labels for better displays
wk.add({
    { "<leader>f", group = "fzf" },
    { "<leader>fg", group = "LSP" },
})

wk.setup {
  preset = "classic",
  plugins = {
      marks = true,
      spelling = { enabled = false },
      presets = {
          operators = false,
      },
  },
  icons = {
    mappings = false,
  },
}
