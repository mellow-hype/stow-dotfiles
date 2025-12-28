
-- rust stuff
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = {"*.rs"},
    command = "set filetype=rust"
})

-- go stuff
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = {"*.go"},
    command = "set filetype=go"
})

-- python stuff
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = {"*.py"},
    command = "set filetype=python"
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    command = "setlocal foldmethod=indent expandtab tabstop=4 shiftwidth=4 softtabstop=4"
})

-- markdown stuff
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = {"*.md"},
    command = "set filetype=markdown"
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    command = "setlocal colorcolumn=100 textwidth=100 conceallevel=2 wrap"
})

-- sway config
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = {"*sway/config.d/*"},
    command = "set filetype=swayconfig"
})

-- dunstrc config
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = {"*/dunstrc"},
    command = "set filetype=dosini"
})


