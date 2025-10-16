function setup_colors()
    local colors = require('tokyonight.colors').setup()
    local f = require('utils.functions')
    local blend_factor = 0.5
    vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = colors.green })
    vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = colors.yellow })
    vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = colors.red })
    vim.api.nvim_set_hl(0, 'GitSignsTopdelete', { fg = colors.red })
    vim.api.nvim_set_hl(0, 'GitSignsStagedAdd', { fg = f.blend_colors(colors.green, colors.bg, blend_factor) })
    vim.api.nvim_set_hl(0, 'GitSignsStagedChange', { fg = f.blend_colors(colors.yellow, colors.bg, blend_factor) })
    vim.api.nvim_set_hl(0, 'GitSignsStagedDelete', { fg = f.blend_colors(colors.red, colors.bg, blend_factor) })
    vim.api.nvim_set_hl(0, 'GitSignsuStagedTopdelete', { fg = f.blend_colors(colors.red, colors.bg, blend_factor) })
end

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
        { '<leader>gs', '<Cmd>Gitsigns stage_hunk<CR>' },
        { '<leader>gu', '<Cmd>Gitsigns undo_stage_hunk<CR>' },
        { '<leader>gr', '<Cmd>Gitsigns reset_hunk<CR>' },
        { '<leader>gt', '<Cmd>Gitsigns toggle_current_line_blame<CR>' },
        { '<leader>gp', '<Cmd>Gitsigns preview_hunk_inline<CR>' }, 
    },
    config = function(_, opts)
        require('gitsigns').setup(opts)
        setup_colors()
    end
}
