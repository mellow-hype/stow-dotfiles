
require("nvim-treesitter").setup {
  ensure_installed = {
      "bash",
      "c",
      "cpp",
      "lua",
      "make",
      "html",
      "markdown",
      "python",
      "json",
      "toml",
      "vim",
      "yaml",
  },
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true,          -- false will disable the whole extension
    disable = { "help" },   -- list of language that will be disabled
  },
  indent = {enable = true},
}
