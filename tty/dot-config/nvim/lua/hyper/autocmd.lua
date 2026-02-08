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


-- highlight around yanked text to make it clear what was yanked
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  desc = "Highlight selection on yank",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch", -- use the IncSearch highlight group
      timeout = 500,         -- highlight for 500 milliseconds
    })
  end,
})

-- Return to last edited line upon reopen
vim.cmd([[
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]])
