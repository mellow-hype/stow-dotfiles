local setkey = nil
if vim.v.version >= 700 then
    setkey = vim.keymap.set
else
    setkey = vim.api.nvim_set_keymap
end

setkey("n", "<leader>g<leader>", ":Git<cr>", {})
setkey("n", "<leader>gs", ":Git status<cr>", {})
setkey("n", "<leader>gl", ":Git log<cr>", {})
setkey("n", "<leader>gpo", ":Git push origin ", {})

