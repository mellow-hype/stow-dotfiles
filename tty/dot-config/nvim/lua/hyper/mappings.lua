vim.g.mapleader = " "

-- use nvim_set_keymap for nvim versions prior to 0.7
local setkey = nil
if vim.v.version >= 700 then
    setkey = vim.keymap.set
else
    setkey = vim.api.nvim_set_keymap
end

-- write and quit
setkey("n", "<leader>w", ":w!<cr>", {})
setkey("n", "<leader>q", ":q<cr>", {})

-- splits
setkey("n", "<leader>vs", ":vsplit<cr>", {})
setkey("n", "<leader>vh", ":split<cr>", {})

-- resizing splits
setkey("n", "<Up>", ":resize +2<cr>", {noremap=true})
setkey("n", "<Down>", ":resize -2<cr>", {noremap=true})
setkey("n", "<Left>", ":vertical resize -2<cr>", {noremap=true})
setkey("n", "<Right>", ":vertical resize +2<cr>", {noremap=true})

-- move between windows
setkey("", "<C-j>", "<C-W>j", {})
setkey("", "<C-k>", "<C-W>k", {})
setkey("", "<C-h>", "<C-W>h", {})
setkey("", "<C-l>", "<C-W>l", {})

-- manage buffers
setkey("n", "<leader>b", ":bprevious<cr>", {})
setkey("n", "<leader>n", ":bnext<cr>", {})
setkey("n", "<leader>x", ":bdelete<cr>", {})

setkey("n", "<leader>ds", vim.diagnostic.open_float, {})
