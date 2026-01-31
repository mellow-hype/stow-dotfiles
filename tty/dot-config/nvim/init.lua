-- plugin manager
require('hyper.packer')
-- custom autocmd
require('hyper.autocmd')
-- global settings
require('hyper.global')
-- custom settings
require('hyper.options')
-- custom keymappings
require('hyper.mappings')
-- custom color settings
require('hyper.colors')

-- Return to last edited line upon reopen
vim.cmd([[
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]])

-- syntax stuff
vim.cmd([[
filetype plugin indent on
syntax enable
]])

