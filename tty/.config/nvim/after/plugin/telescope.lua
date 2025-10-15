if vim.v.version >= 700 then
    require('telescope').setup{
        defaults = {
            layout_strategy = 'flex',
            layout_config = {
                prompt_position = 'top',
                height = 0.95,
                width = 0.90,
            },
        },
    }

    -- config for ivy theme layouts
    local ivy_cfg = {
        layout_config = {
            prompt_position = 'top',
            height = 0.6,
            width = 1.0,
        }
    }
    -- instance of ivy that can be reused
    local ivy = require('telescope.themes').get_ivy(ivy_cfg)

    -- keybinds for telescope
    local builtin = require('telescope.builtin')
    setkey = vim.keymap.set

    -- scope through help tags
    setkey('n', '<leader>fh', builtin.help_tags, {})
    -- scope through open buffers
    setkey('n', '<leader>fo', builtin.buffers, {desc = "buffers"})
    -- scope through files in cwd
    setkey('n', '<leader>ff', function()
        builtin.find_files(ivy)
    end)
    -- scope live grep
    setkey('n', '<leader>fs', function()
        builtin.live_grep(ivy)
    end)
    -- scope grep for selection
    setkey('n', '<leader>fg', builtin.grep_string, {})

    -- scope native vim stuff
    setkey('n', '<leader>vm', builtin.marks, {desc = "marks"})
    setkey('n', '<leader>vj', builtin.jumplist, {desc = "jumplist"})
    setkey('n', '<leader>vv', builtin.registers, {desc = "paste registers"})
    setkey('n', '<leader>vc', builtin.colorscheme, {desc = "colorschemes"})

    -- Autostart telescope if vim was started with a directory arg
    vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
            if vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
                builtin.find_files({ cwd = vim.fn.argv(0) })
            end
        end,
    })
end
