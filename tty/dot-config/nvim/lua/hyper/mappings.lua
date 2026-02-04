local setkey = vim.keymap.set

-- set leader
vim.g.mapleader = " "

-- Change text without putting it into the vim register,
-- see https://stackoverflow.com/q/54255/6064933
setkey("n", "c", '"_c')
setkey("n", "C", '"_C')
setkey("n", "cc", '"_cc')
setkey("x", "c", '"_c')

-- nav: move between windows using <C-[h,j,k,l]>
setkey("", "<C-j>", "<C-W>j")
setkey("", "<C-k>", "<C-W>k")
setkey("", "<C-h>", "<C-W>h")
setkey("", "<C-l>", "<C-W>l")

-- core: resizing splits
setkey("n", "<Up>", ":resize +2<cr>", {noremap=true})
setkey("n", "<Down>", ":resize -2<cr>", {noremap=true})
setkey("n", "<Left>", ":vertical resize -2<cr>", {noremap=true})
setkey("n", "<Right>", ":vertical resize +2<cr>", {noremap=true})


--- ======================================================================================
-- >>> VISUAL MODE BINDS
--- ======================================================================================
-- add/minus to number/alpha in highlighted text
setkey("v", "g+", "g<C-a>", { desc = "increment selection" })
setkey("v", "g=", "g<C-x>", { desc = "decrement selection" })



--- ======================================================================================
--- >>> CORE BINDINGS
--- ======================================================================================
-- core: write/quit
setkey("n", "<leader>w", ":update<cr>", {desc = "update buffer"})
setkey("n", "<leader>q", ":q<cr>",      {desc = "quit"})
setkey("n", "<leader>Q", ":qa!<cr>",    {silent = true, desc = "quit all"})

-- nav: manage buffers
setkey("n", "<leader>b", ":bprevious<cr>",  {desc = "previous buffer"})
setkey("n", "<leader>n", ":bnext<cr>",      {desc = "next buffer"})
setkey("n", "<leader>x", ":BufDel<cr>",     {desc = "bufdel"})
setkey("n", "<leader>X", ":bdelete<cr>",    {desc = "delete buffer"})

-- core: views
setkey("n", "<leader>vs", ":vsplit<cr>",    {desc = "vertical split"})
setkey("n", "<leader>vh", ":split<cr>",     {desc = "horizontal split"})

-- core: tabs
setkey("n", "<leader>tt", ":tabnew<cr>", { desc = "new tab"})
setkey("n", "<leader>tn", ":tabnext<cr>", { desc = "next tab"})
setkey("n", "<leader>tp", ":tabprevious<cr>", { desc = "prev tab"})



--- ======================================================================================
--- >>> UTIL BINDINGS
--- ======================================================================================
setkey('n', '<leader>ur', ":Rename ",   {desc = "Rename"})
setkey('n', '<leader>um', ":Move ",     {desc = "Move"})
setkey('n', '<leader>ud', ":Mkdir ",    {desc = "Mkdir"})
setkey('n', '<leader>uD', ":Delete<cr>", {desc = "Delete"})
setkey("n", "<leader>cd", "<cmd>lcd %:p:h<cr><cmd>pwd<cr>", { desc = "change cwd" })

-- convert binary buffer to ascii hex and vice versa using xxd
setkey("n", "<leader>ux", "<cmd>%!xxd<cr>",     {desc = "xxd hexify"})
setkey("n", "<leader>uX", "<cmd>%!xxd -r<cr>",  {desc = "xxd binify"})

-- Git mappings
setkey('n', '<leader>gc', ":Git commit<cr>", {desc = "git commit"})



--- ======================================================================================
--- >>> LSP/diagnostics bindings
--- ======================================================================================
setkey("n", "grn", vim.lsp.buf.rename,          {desc = "rename variable"})
setkey("n", "gri", vim.lsp.buf.implementation,  {desc = "implementation"})
setkey("n", "grr", vim.lsp.buf.references,      {desc = "references"})
setkey("n", "grt", vim.lsp.buf.type_definition, {desc = "typedefs"})
setkey("n", "gO",  vim.lsp.buf.document_symbol, {desc = "symbols (doc)"})

setkey("i", "<C-s>", vim.lsp.buf.signature_help,{desc = "show signature help"})
setkey("n", "<C-x>d", vim.diagnostic.open_float,{desc = "show diagnostic float"})

-- toggle lsp hover info
setkey('n', 'K', function()
  vim.lsp.buf.hover {
    border = "single",
    close_events = { "CursorMoved", "BufLeave", "WinLeave", "LSPDetach" },
} end, { desc = "Toggle hover" })

-- toggle virtual text inline diagnostics
setkey('n', 'gK', function()
  local new_config = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = 'Toggle diagnostic virtual_lines' })

-- smart goto definition
setkey("n", "gd", function()
  vim.lsp.buf.definition {
    on_list = function(options)
      local unique_defs = {}
      local def_loc_hash = {}

      -- each item in options.items contain the location info for a definition provided by LSP server
      for _, def_location in pairs(options.items) do
        -- use filename and line number to uniquely indentify a definition,
        -- we do not expect/want multiple definition in single line!
        local hash_key = def_location.filename .. def_location.lnum

        if not def_loc_hash[hash_key] then
          def_loc_hash[hash_key] = true
          table.insert(unique_defs, def_location)
        end
      end

      options.items = unique_defs

      -- set the location list
      ---@diagnostic disable-next-line: param-type-mismatch
      vim.fn.setloclist(0, {}, " ", options)

      -- open the location list when we have more than 1 definitions found,
      -- otherwise, jump directly to the definition
      if #options.items > 1 then
        vim.cmd.lopen()
      else
        vim.cmd([[silent! lfirst]])
      end
    end,
  }
end, { desc = "Goto definition" })

