
-- configure capabilities

return {
  on_init = function(client)
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if
          path ~= vim.fn.stdpath('config')
          and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
        then
          return
        end
      end

      local caps = vim.lsp.protocol.make_client_capabilities()
      caps = vim.tbl_deep_extend('force', caps, require('cmp_nvim_lsp').default_capabilities())
      client.config.capabilities = vim.tbl_deep_extend('force', client.config.capabilities or {}, caps)
      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          version = 'LuaJIT',
          path = {
            'lua/?.lua',
            'lua/?/?.lua',
          },
        },
        diagnostics = {
            globals = {"vim"},
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = {
              '${3rd}/luv/library',
              unpack(vim.api.nvim_get_runtime_file('', true)),
              vim.env.VIMRUNTIME,
          },
        },
      })
  end,

  capabilities = {},
  cmd = { "/run/current-system/sw/bin/zsh", "-c", "'lua-language-server'" },
  filetypes = { 'lua' },
  root_markers = { 'init.lua' },
  settings = {
    Lua = {
        hint = {
          enable = false,
        },
        runtime = {
          version = 'LuaJIT',
          path = {
            'lua/?.lua',
            '?/init.lua',
          },
        },
        diagnostics = {
            globals = {"vim"},
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
          },
        },
    },
  },
}
