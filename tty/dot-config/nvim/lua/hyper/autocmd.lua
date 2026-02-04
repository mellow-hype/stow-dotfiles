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


-- Return to last edited line upon reopen
vim.cmd([[
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]])
