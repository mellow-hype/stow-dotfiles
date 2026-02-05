
local dap = require('dap')
local dap_util = require('hyper.util')

-- Configuration for C/CPP/Rust via gdb
dap.adapters.gdb = {
    type = 'executable',
    command = 'gdb',
    args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
}

dap.configurations.c = {
    {
        name = "launch",
        type = "gdb",
        request = "launch",
        program = dap_util.input_exec_path,
        cwd = '${workspaceFolder}',
        args = dap_util.input_args,
        terminal = 'integrated',
    },
}
dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = dap.configurations.c


local setkey = vim.keymap.set
setkey("n", "<leader>dd", dap.continue, {desc = "debug: launch"})
setkey("n", "<leader>db", dap.toggle_breakpoint, {desc = "debug: toggle breakpoint"})
setkey("n", "<leader>dC", dap.clear_breakpoints, {desc = "debug: clear breakpoints"})
setkey("n", "<leader>dc", dap.run_to_cursor, {desc = "debug: run to cursor"})
setkey("n", "<leader>do", dap.repl.open, {desc = "debug: open repl"})
setkey("n", "<leader>dt", dap.terminate, {desc = "debug: terminate"})
