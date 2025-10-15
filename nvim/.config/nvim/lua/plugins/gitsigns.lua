return {
    'lewis6991/gitsigns.nvim',
    event = { 'bufreadpre', 'bufnewfile' },
    opts = {
        signs = {
            add          = { text = '│' },
            change       = { text = '│' },
            delete       = { text = '_' },
            topdelete    = { text = '‾' },
            changedelete = { text = '~' },
            untracked    = { text = '┆' },
        },
        signs_staged = {
            add          = { text = '│' },
            change       = { text = '│' },
            delete       = { text = '_' },
            topdelete    = { text = '‾' },
            changedelete = { text = '~' },
            untracked    = { text = '┆' },
        },
        current_line_blame_opts = {
            delay = 100
        },
    },
    keys = {
        { '<leader>gs', '<Cmd>Gitsigns stage_hunk<CR>', mode = 'n' },
        { '<leader>gu', '<Cmd>Gitsigns undo_stage_hunk<CR>', mode = 'n' },
        { '<leader>gr', '<Cmd>Gitsigns reset_hunk<CR>', mode = 'n' },
        { '<leader>gt', '<Cmd>Gitsigns toggle_current_line_blame<CR>', mode = 'n' },
        { '<leader>gp', '<Cmd>Gitsigns preview_hunk_inline<CR>', mode = 'n' }, 
        { '<leader>gn', '<Cmd>Gitsigns next_hunk<CR>', mode = 'n' }
    },
}
