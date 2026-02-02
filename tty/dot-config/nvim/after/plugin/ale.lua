
-- local setkey = vim.keymap.set

-- setkey("n", "gd", ":ALEGoToDefinition<cr>", {})
-- setkey("n", "gI", ":ALEGoToImplementation<cr>", {})
-- setkey("n", "gr", ":ALEFindReferences<cr>", {})

-- -- jumps
-- setkey("n", "<leader>ad", ":ALEGoToDefinition<cr>", {desc = "ALE goto definition"})
-- setkey("n", "<leader>aI", ":ALEGoToImplementation<cr>", {desc = "ALE goto implementation"})
-- setkey("n", "<leader>ar", ":ALEFindReferences<cr>", {desc = "ALE find references"})

-- -- symbol search
-- setkey("n", "<leader>ss", ":ALESymbolSearch ", {desc = "ALE symbol search"})

-- -- misc
-- setkey("n", "<leader>aR", ":ALERename<cr>", {desc = "ALE rename symbol"})
-- setkey("n", "<leader>ah", ":ALEHover<cr>", {})

-- -- setup for linters and fixers
-- vim.cmd([[

-- let g:ale_linters = {
--     \'rust': ['analyzer'],
--     \'cpp': ['clangd'],
--     \'c': ['clangd'],
--     \'python': ['pylint']
-- \}

-- let g:ale_fixers = {
--     \'*': ['trim_whitespace'],
--     \'rust': ['rustfmt'],
--     \'cpp': ['clang-format'],
--     \'c': ['clang-format']
-- \}

-- " use quickfix instead of loclist
-- let g:ale_set_quickfix = 1
-- let g:ale_set_loclist = 0
-- " don't show virtual text in the document
-- let g:ale_virtualtext_cursor = 'disabled'
-- ]])
