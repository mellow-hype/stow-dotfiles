
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

-- files in cwd
vim.keymap.set('n', '<leader>ff', fzflua.files, {})

-- open buffers
vim.keymap.set('n', '<leader>fo', fzflua.buffers, {})
vim.keymap.set('n', '<leader>fb', fzflua.buffers, {})

-- live-grep
vim.keymap.set('n', '<leader>fs', fzflua.live_grep, {})     -- full project search
vim.keymap.set('n', '<leader>f/', fzflua.lgrep_curbuf, {})  -- local search

-- native vim stuff
vim.keymap.set('n', '<leader>vm', fzflua.marks, {})
vim.keymap.set('n', '<leader>vj', fzflua.jumps, {})
vim.keymap.set('n', '<leader>vv', fzflua.registers, {})

-- Autostart files picker if vim was started with a directory arg
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        if vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
            fzflua.files({ cwd = vim.fn.argv(0) })
        end
    end,
})

