
-- utility module for project-wide use

local M = {}

-- ==========================================================================================
--- DAP
-- ==========================================================================================
--- Get a file path from input
M.input_exec_path = function()
  return vim.fn.input('Path to executable (default to "a.out"): ', vim.fn.expand("%:p:h") .. "/a.out", "file")
end

M.input_args = function()
  local argument_string = vim.fn.input("Program arg(s) (enter nothing to leave it null): ")
  return vim.fn.split(argument_string, " ", true)
end

M.input_file_path = function()
  return vim.fn.input("Path to debuggee (default to the current file): ", vim.fn.expand("%:p"), "file")
end


--- Used to pop open the fzf file picker vim is passed a directory for editing
M.open_dir_picker = function(data)
  local fzflua = require('fzf-lua')

  local directory = vim.fn.isdirectory(data.file) == 1
  if not directory then
    return
  end

  -- create a new, empty buffer
  vim.cmd.enew()
  -- wipe the directory buffer
  vim.cmd.bw(data.buf)
  -- open the fzf file picker
  fzflua.files({ cwd = vim.fn.argv(0) })
end


-- toggle dianostic virtual lines in buffer
M.toggle_diag_lines = function()
  local new_config = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = new_config })
end


-- use fzf-lua file picker to open or create
M.fzf_file_ocreate = function()
  local fzflua = require('fzf-lua')
  fzflua.files({
    actions = {
      ["default"] = function(selected, opts)
        local selected_item = selected[1]
        local status, entry =
            pcall(fzflua.path.entry_to_file, selected_item, opts, opts.force_uri)
        local last_query =
            fzflua.config.__resume_data.last_query
        if selected_item and status and vim.loop.fs_stat(entry.path) then
            -- file exists: edit file
            fzflua.actions.file_edit(selected, opts)
        else
          -- file not exists: create new
          vim.cmd("e " .. last_query)
        end
      end,
    },
  })
end

return M

