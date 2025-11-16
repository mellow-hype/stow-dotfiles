-- general settings
vim.opt.compatible = false
vim.opt.encoding = "utf-8"
vim.opt.completeopt="menu,menuone,preview,noselect,noinsert"

-- backups/caching
vim.opt.history = 1000
vim.opt.backup = false
vim.opt.wb = false
vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- mouse support
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'

-- general ui
vim.opt.number = true
vim.opt.relativenumber = true

--cursor and ruler
vim.opt.ruler = true
vim.opt.cursorline = true

-- show column at 100
vim.opt.colorcolumn = "100"

-- list
vim.opt.list = true
vim.opt.listchars = {
    tab = '>-',
    trail = '~',
    extends = '>',
    precedes = '<'
}

-- tabs and stuff
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

-- indent
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wildmenu = true

-- search
vim.opt.showmatch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

-- folding
vim.opt.foldmethod = "indent"
vim.opt.foldnestmax = 10
vim.opt.foldenable = false
vim.opt.foldlevel = 10

-- backspace
vim.opt.backspace="eol,start,indent"
vim.opt.whichwrap:append("<,>,h,l")
