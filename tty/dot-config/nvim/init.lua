
-- Return to last edited line upon reopen
vim.cmd([[
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]])

-- syntax stuff
vim.cmd([[
filetype plugin indent on
syntax enable
]])

--- Modules
-- plugin manager
require('hyper.packer')
-- lsp setup
require('hyper.lsp')
-- global settings
require('hyper.global')
-- options
require('hyper.options')
-- custom autocmd
require('hyper.autocmd')
-- keymappings
require('hyper.mappings')
-- diagnostics configs
require('hyper.diagcfg')

-- color settings
require('hyper.colors')

