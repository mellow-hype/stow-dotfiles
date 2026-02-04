
-- setup for completion via cmp
local cmp = require("cmp")
require("cmp_nvim_lsp")
require("cmp_path")
require("cmp_buffer")
require("cmp_omni")

cmp.setup{
    mapping = cmp.mapping.preset.insert {
        ["<Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end,
        ["<CR>"] = cmp.mapping.confirm { select = true },
        ["<C-c>"] = cmp.mapping.close(),
        ["<C-e>"] = cmp.mapping.abort(),
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer", keyword_length = 2 },
    },
    completion = {
        keyword_length = 1,
        completeopt = "menu,noselect",
    },
}


