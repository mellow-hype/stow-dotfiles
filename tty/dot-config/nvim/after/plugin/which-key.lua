
local wk = require('which-key')

-- add specific groups with labels for better displays
wk.add({
    { "gr", group = "vim.lsp" },
    { "<leader>f", group = "file" },
    { "<leader>s", group = "search" },
    { "<leader>e", group = "edit" },
    { "<leader>g", group = "git" },
    { "<leader>m", group = "misc" },
    { "<leader>v", group = "views" },
    { "<leader>t", group = "tabs" },

    { "<leader>u", group = "util" },
    { "<leader>uf", group = "file ops" },
    { "<leader>ux", group = "xxd ops" },

    { "<leader>l", group = "lsp" },
    { "<leader>d", group = "debugger" },
})

wk.setup {
  preset = "classic",
  plugins = {
      marks = true,
      spelling = { enabled = false },
      presets = {
          motions = false,
          operators = false,
      },
  },
  icons = {
    mappings = false,
  },
}
