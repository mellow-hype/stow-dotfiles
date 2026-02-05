
local testfunc = function()
end

local goto_def = function(options)
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
end

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local fzflua = require('fzf-lua')

    --- ================================================================================
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, {buffer = event.buf, desc = 'lsp: ' .. desc})
    end
    -- leader-bound fzf lsp interfaces
    map('<leader>ld', fzflua.lsp_definitions,      "definitions")
    map('<leader>lD', fzflua.lsp_declarations,     "declarations")
    map('<leader>lx', fzflua.lsp_references,       "references")
    map('<leader>lI', fzflua.lsp_implementations,  "implementations")
    map('<leader>lt', fzflua.lsp_typedefs,         "typedefs")
    map('<leader>lk', fzflua.diagnostics_document, "diagnostics")
    map('<leader>la', fzflua.lsp_code_actions,     "code actions")
    -- search
    map('<leader>ls', fzflua.lsp_document_symbols, "document symbols")
    map('<leader>lw', fzflua.lsp_workspace_symbols, "workspace symbols")
    map('<leader>lc', fzflua.lsp_incoming_calls,   "incoming calls")

    -- goto/action binds
    map("grn", vim.lsp.buf.rename,              "rename symbol")
    map("gri", vim.lsp.buf.implementation,      "goto impl")
    map("grt", vim.lsp.buf.type_definition,     "goto typedef")

    -- smart goto definition
    map("gd", function()
      vim.lsp.buf.definition { on_list = goto_def }
    end, 'goto definition')

    -- diagnostic/help binds
    local util = require('hyper.util')
    map("gk", vim.diagnostic.open_float, "show diagnostic float")
    map('gK', util.toggle_diag_lines, 'Toggle diagnostic virtual_lines')

    -- hover
    map('K', function()
      vim.lsp.buf.hover {
        border = "single",
        close_events = { "CursorMoved", "BufLeave", "WinLeave", "LSPDetach" },
    } end, "Toggle hover")
    map("<C-s>", vim.lsp.buf.signature_help,    "show signature help")

    --- ================================================================================
    -- configure capabilities + add cmp_nvim_lsp caps
    local caps = vim.lsp.protocol.make_client_capabilities()
    caps = vim.tbl_deep_extend('force', caps, require('cmp_nvim_lsp').default_capabilities())
    -- configure servers
    local servers = {
      'lua-language-server',
      'clangd',
      'nixd',
    }
    for _, server_name in ipairs(servers) do
      local server = {}
      server.capabilities = vim.tbl_deep_extend('force', {}, caps, server.capabilities or {})
      vim.lsp.config(server_name, server)
    end
  end
})


vim.lsp.enable({
  "clangd",
  "lua-language-server",
  "docker_language_server",
  "nixd",
})

