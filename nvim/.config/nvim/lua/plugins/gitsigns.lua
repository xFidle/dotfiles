return {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
        signs = {
            add          = { text = '+' },
            change       = { text = '~' },
            delete       = { text = '_' },
            topdelete    = { text = '‾' },
            changedelete = { text = '~' },
            untracked    = { text = '┆' },
        },
        signs_staged = {
            add          = { text = '+' },
            change       = { text = '~' },
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
        { '<leader>gs', function() require('gitsigns').stage_hunk() end,
            desc = 'Stage hunk' },

        { '<leader>gu', function() require('gitsigns').undo_stage_hunk() end,
            desc = 'Undo stage hunk' },

        { '<leader>gr', function() require('gitsigns').reset_hunk() end,
            desc = 'Reset hunk' },

        { '<leader>gt', function() require('gitsigns').toggle_current_line_blame() end,
            desc = 'Toggle current line blame' },

        { '<leader>gp', function() require('gitsigns').preview_hunk_inline() end,
            desc = 'Preview hunk inline' },
    },
}
