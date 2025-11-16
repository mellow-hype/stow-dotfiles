
local setkey = nil
if vim.v.version >= 700 then
    setkey = vim.keymap.set
else
    setkey = vim.api.nvim_set_keymap
end

setkey("n", "<leader>t", ":NERDTreeToggle<cr>", {noremap=true})

vim.cmd([[
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
]])

