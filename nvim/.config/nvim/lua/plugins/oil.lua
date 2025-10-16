return {
    'stevearc/oil.nvim',
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    opts = {
        default_file_explorer = true,
        delete_to_trash = true,
        watch_for_changes = true,
        view_options = {
            show_hidden = true,
        },
        keymaps = {
            ["<C-h>"] = false,
            ["<C-j>"] = false,
            ["<C-k>"] = false,
            ["<C-l>"] = false,
        },
        confirmation = { border = 'rounded' },
        keymaps_help = { border = 'rounded' }
    },
    keys = {
        { '-', ':Oil<CR>' },
        { '_', function() require('oil').open(vim.fn.getcwd()) end },
    },
}
