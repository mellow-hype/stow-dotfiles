
-- initial setup
local fzflua = require('fzf-lua')
fzflua.setup({
  "max-perf",
  files = {
    hidden = false, -- don't show hidden files in search by default
    follow = true,  -- follow symlinks
  },
  winopts = {
    width = 0.80,
    row = 0.40,
    col = 0.50,
    preview = { hidden = true },
  },
  keymap = {
    builtin = {
      ["<M-a>"] = "toggle-preview",
      ["<M-w>"] = "toggle-hidden",
    },
  },
})


--- ======================================================================================
--- >>> PICKER BINDINGS
--- ======================================================================================
local setkey = vim.keymap.set
setkey('n', '<leader>,', fzflua.buffers,    {desc = "fzf buffers"})

-- picker: files/buffers
setkey('n', '<leader>fb', fzflua.buffers,   {desc = "fzf buffers"})
setkey('n', '<leader>ff', fzflua.files,     {desc = "fzf files"})
setkey('n', '<leader>fh', fzflua.oldfiles,  {desc = "fzf oldfiles"})

-- picker: searching
setkey('n', '<leader>s/', fzflua.lgrep_curbuf, {desc = "search buffer"})
setkey('n', '<leader>ss', fzflua.live_grep, {desc = "livegrep"})
setkey('n', '<leader>sw', fzflua.grep_cword,{desc = "search cursor word"})
setkey('n', '<leader>sW', fzflua.grep_cWORD,{desc = "search cursor WORD"})
setkey('n', '<leader>sh', fzflua.helptags,  {desc = "search helptags"})

-- picker: misc menus
setkey('n', '<leader>mm', fzflua.marks,     {desc = "fzf marks"})
setkey('n', '<leader>mj', fzflua.jumps,     {desc = "fzf jumplist"})
setkey('n', '<leader>my', fzflua.registers, {desc = "fzf registers"})
setkey('n', '<leader>mt', fzflua.tabs,      {desc = "fzf tabs"})
setkey('n', '<leader>mC', fzflua.colorschemes, {desc = "fzf colorschemes"})

-- picker: git
setkey('n', '<leader>gs', fzflua.git_status,    {desc = "git status"})
setkey('n', '<leader>gl', fzflua.git_commits,   {desc = "git log"})


--- ======================================================================================
--- >>> CUSTOM BINDINGS
--- ======================================================================================
local util = require('hyper.util')

--- Create new file using fzf prompt entry
vim.keymap.set("n", "<leader>fn", util.fzf_file_ocreate, {desc = "new file"})

-- Autostart files picker if vim was started with a directory arg
vim.api.nvim_create_autocmd("VimEnter", { callback = util.open_dir_picker })

