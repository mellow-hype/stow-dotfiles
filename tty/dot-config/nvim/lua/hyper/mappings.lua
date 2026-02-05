local setkey = vim.keymap.set

-- set leader
vim.g.mapleader = " "

-- Change text without putting it into the vim register,
-- see https://stackoverflow.com/q/54255/6064933
setkey("n", "c", '"_c')
setkey("n", "C", '"_C')
setkey("n", "cc", '"_cc')
setkey("x", "c", '"_c')

--- ======================================================================================
-- >>> VISUAL MODE BINDS
--- ======================================================================================
-- add/minus to number/alpha in highlighted text
setkey("v", "g+", "g<C-a>", { desc = "increment selection" })
setkey("v", "g=", "g<C-x>", { desc = "decrement selection" })


--- ======================================================================================
--- >>> CORE BINDINGS
--- ======================================================================================
-- core: write/quit
setkey("n", "<leader>w", ":update<cr>", {desc = "update buffer"})
setkey("n", "<leader>q", ":q<cr>",      {desc = "quit"})
setkey("n", "<leader>Q", ":qa!<cr>",    {silent = true, desc = "quit all"})

-- nav: buffer nav
setkey("n", "<leader>b", ":bprevious<cr>",  {desc = "previous buffer"})
setkey("n", "<leader>n", ":bnext<cr>",      {desc = "next buffer"})
setkey("n", "<leader>x", ":BufDel<cr>",     {desc = "bufdel"})
setkey("n", "<leader>X", ":bdelete<cr>",    {desc = "delete buffer"})


--- ======================================================================================
--- >>> VIEWPORT BINDINGS (v)
--- ======================================================================================
setkey("n", "<leader>vs", ":vsplit<cr>",    {desc = "vertical split"})
setkey("n", "<leader>vh", ":split<cr>",     {desc = "horizontal split"})
-- core: resizing splits
setkey("n", "<Up>", ":resize +2<cr>", {noremap=true})
setkey("n", "<Down>", ":resize -2<cr>", {noremap=true})
setkey("n", "<Left>", ":vertical resize -2<cr>", {noremap=true})
setkey("n", "<Right>", ":vertical resize +2<cr>", {noremap=true})
-- nav: move between windows using <C-[h,j,k,l]>
setkey("", "<C-j>", "<C-W>j")
setkey("", "<C-k>", "<C-W>k")
setkey("", "<C-h>", "<C-W>h")
setkey("", "<C-l>", "<C-W>l")

--- ======================================================================================
--- >>> TABS BINDINGS (t)
--- ======================================================================================
setkey("n", "<leader>tt", ":tabnew<cr>", { desc = "new tab"})
setkey("n", "<leader>tn", ":tabnext<cr>", { desc = "next tab"})
setkey("n", "<leader>tp", ":tabprevious<cr>", { desc = "prev tab"})

--- ======================================================================================
--- >>> EDIT BINDINGS (e)
--- ======================================================================================
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

--- ======================================================================================
--- >>> UTIL BINDINGS (u)
--- ======================================================================================
setkey('n', '<leader>ufr', ":Rename ",   {desc = "Rename"})
setkey('n', '<leader>ufm', ":Move ",     {desc = "Move"})
setkey('n', '<leader>ufd', ":Mkdir ",    {desc = "Mkdir"})
setkey('n', '<leader>ufD', ":Delete<cr>", {desc = "Delete"})
-- convert binary buffer to ascii hex and vice versa using xxd
setkey("n", "<leader>uxx", "<cmd>%!xxd<cr>",     {desc = "xxd hexify"})
setkey("n", "<leader>uxb", "<cmd>%!xxd -r<cr>",  {desc = "xxd binify"})
setkey("n", "<leader>cd", "<cmd>lcd %:p:h<cr><cmd>pwd<cr>", { desc = "change cwd" })

--- ======================================================================================
--- >>> GIT BINDINGS (g)
--- ======================================================================================
setkey('n', '<leader>gc', ":Git commit<cr>", {desc = "git commit"})

