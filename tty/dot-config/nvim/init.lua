-- Minimal Neovim config (plugin-free)
-- Full config lives in priv-configs/configs/dot-config/nvim/

vim.cmd([[
filetype plugin indent on
syntax enable
]])

-- =============================================================================
-- Disable unused providers
-- =============================================================================
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_2html_plugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1

-- =============================================================================
-- Options
-- =============================================================================
vim.opt.compatible = false
vim.opt.encoding = "utf-8"
vim.opt.completeopt = "menu,menuone,preview,noselect,noinsert"

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
vim.opt.showcmd = false
vim.opt.ruler = true
vim.opt.cursorline = true
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
vim.opt.smarttab = true
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
vim.opt.wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**"

-- folding
vim.opt.foldmethod = "indent"
vim.opt.foldnestmax = 10
vim.opt.foldenable = false
vim.opt.foldlevel = 10

-- backspace
vim.opt.backspace = "eol,start,indent"
vim.opt.whichwrap:append("<,>,h,l")

-- colors
vim.opt.termguicolors = true
vim.opt.background = "dark"

-- =============================================================================
-- Autocommands
-- =============================================================================
-- custom filetype associations
vim.filetype.add({
  pattern = {
    [".*/sway/config.d/.*"] = "swayconfig",
    [".*/dunstrc"] = "dosini",
  },
})

-- python
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  command = "setlocal foldmethod=indent expandtab tabstop=4 shiftwidth=4 softtabstop=4"
})

-- markdown
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  command = "setlocal colorcolumn=100 textwidth=100 conceallevel=2 wrap"
})

-- lua: tabstop=2
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  command = "setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2"
})

-- highlight around yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  desc = "Highlight selection on yank",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 500,
    })
  end,
})

-- return to last edited line upon reopen
vim.cmd([[
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]])

-- =============================================================================
-- Keymappings
-- =============================================================================
local setkey = vim.keymap.set

-- set leader
vim.g.mapleader = " "

-- change text without putting it into the vim register
setkey("n", "c", '"_c')
setkey("n", "C", '"_C')
setkey("n", "cc", '"_cc')
setkey("x", "c", '"_c')

-- visual mode: increment/decrement
setkey("v", "g+", "g<C-a>", { desc = "increment selection" })
setkey("v", "g=", "g<C-x>", { desc = "decrement selection" })

-- core: write/quit
setkey("n", "<leader>w", ":update<cr>", {desc = "update buffer"})
setkey("n", "<leader>q", ":q<cr>",      {desc = "quit"})
setkey("n", "<leader>Q", ":qa!<cr>",    {silent = true, desc = "quit all"})

-- nav: buffer nav
setkey("n", "<leader>b", ":bprevious<cr>",  {desc = "previous buffer"})
setkey("n", "<leader>n", ":bnext<cr>",      {desc = "next buffer"})
setkey("n", "<leader>X", ":bdelete<cr>",    {desc = "delete buffer"})

-- viewport: splits
setkey("n", "<leader>vs", ":vsplit<cr>",    {desc = "vertical split"})
setkey("n", "<leader>vh", ":split<cr>",     {desc = "horizontal split"})
-- resizing splits
setkey("n", "<Up>", ":resize +2<cr>", {noremap=true})
setkey("n", "<Down>", ":resize -2<cr>", {noremap=true})
setkey("n", "<Left>", ":vertical resize -2<cr>", {noremap=true})
setkey("n", "<Right>", ":vertical resize +2<cr>", {noremap=true})
-- move between windows
setkey("", "<C-j>", "<C-W>j")
setkey("", "<C-k>", "<C-W>k")
setkey("", "<C-h>", "<C-W>h")
setkey("", "<C-l>", "<C-W>l")

-- tabs
setkey("n", "<leader>tt", ":tabnew<cr>", { desc = "new tab"})
setkey("n", "<leader>tn", ":tabnext<cr>", { desc = "next tab"})
setkey("n", "<leader>tp", ":tabprevious<cr>", { desc = "prev tab"})

-- edit
setkey("n", "<leader>eC", "<cmd>tabnew $MYVIMRC <bar> tcd %:h<cr>", {
  silent = true,
  desc = "open vim config",
})
setkey("n", "<leader>ee", vim.cmd.enew, {
  silent = true,
  desc = "open blank buffer",
})
setkey("n", "<leader>en", ":e ", {
  desc = "edit new",
})

-- util: xxd
setkey("n", "<leader>uxx", "<cmd>%!xxd<cr>",     {desc = "xxd hexify"})
setkey("n", "<leader>uxb", "<cmd>%!xxd -r<cr>",  {desc = "xxd binify"})
setkey("n", "<leader>cd", "<cmd>lcd %:p:h<cr><cmd>pwd<cr>", { desc = "change cwd" })
