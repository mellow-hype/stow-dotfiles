
-- initial setup
require("fzf-lua").setup{
    files = {
        hidden = false, -- don't show hidden files in search by default
        follow = true,  -- follow symlinks
    },
    winopts = {
        width = 0.60,
        row = 0.5,
        preview = {
            hidden = true,
            -- delay = 200,
        },
    },
    keymap = {
        builtin = {
            ["<M-a>"] = "toggle-preview",
        },
    },
}

local setkey = vim.keymap.set
local fzflua = require('fzf-lua')

--- ======================================================================================
--- >>> PICKER BINDINGS
--- ======================================================================================
setkey('n', '<leader>H', fzflua.helptags,   {desc = "helptags picker"})
setkey('n', '<leader>,', fzflua.buffers,    {desc = "buffer picker"})
setkey('n', '<leader>/', fzflua.lgrep_curbuf, {desc = "livegrep current"})

-- picker: files/buffers
setkey('n', '<leader>fb', fzflua.buffers,   {desc = "buffer picker"})
setkey('n', '<leader>ff', fzflua.files,     {desc = "file picker"})
setkey('n', '<leader>fh', fzflua.oldfiles,  {desc = "old files"})

-- picker: searching (content)
setkey('n', '<leader>fs', fzflua.live_grep, {desc = "livegrep"})
setkey('n', '<leader>fs', fzflua.live_grep, {desc = "livegrep"})
setkey('n', '<leader>fw', fzflua.grep_cword,{desc = "grep word"})
setkey('n', '<leader>fW', fzflua.grep_cWORD,{desc = "grep WORD"})

-- picker: jumps/navigation
setkey('n', '<leader>fm', fzflua.marks,     {desc = "fzf marks"})
setkey('n', '<leader>fj', fzflua.jumps,     {desc = "fzf jumplist"})
setkey('n', '<leader>fy', fzflua.registers, {desc = "fzf registers"})
setkey('n', '<leader>ft', fzflua.tabs,      {desc = "fzf tabs"})

-- picker: searching (meta)
setkey('n', '<leader>fC', fzflua.colorschemes,  {desc = "colorschemes picker"})

-- picker: diag/lsp
setkey('n', '<leader>fgr', fzflua.lsp_references,        {desc = "fzf references"})
setkey('n', '<leader>fgd', fzflua.lsp_definitions,       {desc = "fzf references"})
setkey('n', '<leader>fgi', fzflua.lsp_implementations,   {desc = "fzf implementations"})
setkey('n', '<leader>fgt', fzflua.lsp_typedefs,          {desc = "fzf typedefs"})
setkey('n', '<leader>fgk', fzflua.diagnostics_document,  {desc = "fzf diagnostics"})
setkey('n', '<leader>fga', fzflua.lsp_code_actions,      {desc = "fzf code actions"})
setkey('n', '<leader>fgo',  fzflua.lsp_document_symbols,  {desc = "fzf symbols"})

-- picker: git
setkey('n', '<leader>gs', fzflua.git_status,    {desc = "git status"})
setkey('n', '<leader>gl', fzflua.git_commits,   {desc = "git log"})



local function open_dir_picker(data)
  -- check if buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  -- create a new, empty buffer
  vim.cmd.enew()

  -- wipe the directory buffer
  vim.cmd.bw(data.buf)

  -- open the tree
  fzflua.files({ cwd = vim.fn.argv(0) })
end

-- Autostart files picker if vim was started with a directory arg
vim.api.nvim_create_autocmd("VimEnter", { callback = open_dir_picker })

