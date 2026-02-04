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
-- plugin manager
require('hyper.packer')
-- completion setup
require('hyper.completion')
-- lsp setup
require('hyper.lsp')
-- dashboard
require('hyper.dash')
-- custom autocmd
require('hyper.autocmd')
-- keymappings
require('hyper.mappings')
-- diagnostics configs
require('hyper.diagcfg')
-- color settings
require('hyper.colors')

