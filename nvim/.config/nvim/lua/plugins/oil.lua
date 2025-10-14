return {
    'stevearc/oil.nvim',
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
    },
    keys = {
        { '-', '<cmd>Oil<CR>', mode = 'n' },
        { '_', '<cmd>Oil<CR>_', mode = 'n' },
    },
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    lazy = false,
}
