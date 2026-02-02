
local diagnostic = vim.diagnostic
local api = vim.api

diagnostic.config {
    underline = true,
    virtual_text = false,
    virtual_lines = false,
    float = {
        source = true,
        border = "single",
        prefix = " ",
        max_height = 20,
        max_width = 130,
        close_events = { "CursorMoved", "BufLeave", "WinLeave", "InsertEnter" },
    },
}

api.nvim_create_autocmd("CursorHold", {
  pattern = "*",
  callback = function()
    if #vim.diagnostic.get(0) == 0 then
      return
    end

    if not vim.b.diagnostics_pos then
      vim.b.diagnostics_pos = { nil, nil }
    end

    local cursor_pos = api.nvim_win_get_cursor(0)

    if not vim.deep_equal(cursor_pos, vim.b.diagnostics_pos) then
      diagnostic.open_float {}
    end

    vim.b.diagnostics_pos = cursor_pos
  end,
})
