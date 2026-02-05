
local dap = require('dap')
local ui = require('dapui')

ui.setup{
    controls = {
        enabled = true,
        element = "repl",
    },
    layouts = {
        {
            elements = {
                { id = 'breakpoints', size = 0.1 },
                { id = 'stacks', size = 0.3 },
                { id = 'scopes', size = 0.6 },
            },
            size = 0.2,
            position = 'right',
        },
        {
            elements = {
                { id = 'console', size = 0.5 },
                { id = 'repl', size = 0.5 },
            },
            position = 'bottom',
            size = 0.2,
        },
    },
}

-- Configure automatic handlers for dap-ui
dap.listeners.before.attach.dapiu_config = function()
    ui.open()
end

dap.listeners.before.launch.dapiu_config = function()
    ui.open()
end

dap.listeners.before.event_terminated.dapiu_config = function()
    ui.close()
end

dap.listeners.before.event_exited.dapiu_config = function()
    ui.close()
end

-- Override signs for side bucket

local icons = require('hyper.icons').get('dap')
vim.fn.sign_define(
    "DapBreakpoint",
    { text = icons.Breakpoint, texthl = "DapBreakpoint", linehl = "", numhl = "" }
)
vim.fn.sign_define(
    "DapBreakpointRejected",
    { text = icons.BreakpointRejected, texthl = "DapBreakpoint", linehl = "", numhl = "" }
)
vim.fn.sign_define(
    "DapStopped",
    { text = icons.Stopped, texthl = "DapStopped", linehl = "", numhl = "" }
)


local setkey = vim.keymap.set
setkey("n", "<leader>dv", ui.toggle, {desc = "debug: toggle UI"})
