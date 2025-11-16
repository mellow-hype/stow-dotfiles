
require("fzf-lua").setup{
    files = {
        hidden = false, -- don't show hidden files in search by default
        follow = true,  -- follow symlinks
    }
}

local fzflua = require('fzf-lua')
setkey = vim.keymap.set

-- open buffers
setkey('n', '<leader>fo', fzflua.buffers, {})

-- files in cwd
setkey('n', '<leader>ff', fzflua.files, {})

-- live-grep
setkey('n', '<leader>fs', fzflua.live_grep, {})
setkey('n', '<leader>f/', fzflua.lgrep_curbuf, {})

-- native vim stuff
setkey('n', '<leader>vm', fzflua.marks, {})
setkey('n', '<leader>vj', fzflua.jumps, {})
setkey('n', '<leader>vv', fzflua.registers, {})

-- Autostart files picker if vim was started with a directory arg
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        if vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
            fzflua.files({ cwd = vim.fn.argv(0) })
        end
    end,
})

