
require("fzf-lua").setup{
    files = {
        hidden = false, -- don't show hidden files in search by default
        follow = true,  -- follow symlinks
    },
    winopts = {
        row = 0.5,
    },
}

local fzflua = require('fzf-lua')

-- Autostart files picker if vim was started with a directory arg
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        if vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
            fzflua.files({ cwd = vim.fn.argv(0) })
        end
    end,
})

