-- syntax stuff
vim.cmd([[
filetype plugin indent on
syntax enable
]])

--- Modules
-- global settings
require('hyper.global')
-- options
require('hyper.options')
-- custom autocmd
require('hyper.autocmd')
-- plugin manager
require('hyper.packer')
-- completion setup
require('hyper.completion')
-- lsp setup
require('hyper.lsp')
-- dashboard
require('hyper.dash')
-- keymappings
require('hyper.mappings')
-- diagnostics configs
require('hyper.diagcfg')
-- color settings
require('hyper.colors')

