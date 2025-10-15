-- plugin manager
require('hyper.packer')
-- custom keymappings
require('hyper.remap')
-- custom settings
require('hyper.set')
-- custom color settings
require('hyper.colors')
-- custom autocmd
require('hyper.autocmd')

-- Return to last edited line upon reopen
vim.cmd([[
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]])

-- some other settings
vim.cmd([[
filetype plugin indent on
syntax enable
let g:ale_completion_enabled = 1
]])

