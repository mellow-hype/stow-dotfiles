
-- -- Bindings
-- vim.keymap.set("n", "<leader>t", ":NERDTreeToggle<cr>", {noremap=true})


-- -- Close the tab if NERDTree is the only window remaining in it.
-- vim.cmd([[
-- autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
-- ]])

