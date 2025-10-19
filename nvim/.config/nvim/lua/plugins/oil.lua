return {
    'stevearc/oil.nvim',
    dependencies = { { 'nvim-mini/mini.icons', opts = {} } },
    opts = {
        default_file_explorer = true,
        delete_to_trash = true,
        watch_for_changes = true,
        view_options = {
            show_hidden = true,
        },
        keymaps = {
            ['<C-h>'] = false,
            ['<C-j>'] = false,
            ['<C-k>'] = false,
            ['<C-l>'] = false,
        },
        float = { border = 'rounded' },
        confirmation = { border = 'rounded' },
        keymaps_help = { border = 'rounded' }
    },
    keys = {
        { '-', function() require('oil').open_float() end, 
            desc = 'Open oil' },

        { '_', function() require('oil').open_float(vim.fn.getcwd()) end, 
            desc = 'Open oil in cwd' },
    },
}
