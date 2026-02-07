-- enable full color support
vim.opt.termguicolors = true
-- set default background
vim.opt.background = "dark"

local dark_themes = {}

dark_themes.base16_gruvbox = function()
  -- set colorscheme
  vim.cmd.colorscheme('base16-gruvbox-dark-hard')
end

dark_themes.horizon_dark = function()
  -- set colorscheme
  vim.cmd.colorscheme('base16-horizon-terminal-dark')
end

-- enable desired theme
dark_themes.horizon_dark()
