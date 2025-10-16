return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        options = {
            theme = 'tokyonight',
            icons_enabled = true,
            globalstatus = true,
            component_separators = { left = '', right = ''},
            section_separators = { left = '', right = ''},
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 
                { 'branch', icon='' },
                'diff',
            },
            lualine_c = { 
                function ()
                    local filename = vim.fn.expand('%:t')
                    local extension = vim.fn.expand('%:e')
                    local icon, color = require('nvim-web-devicons').get_icon_color(filename, extension)
                    local hl_group = 'LualineFileIconColor' .. extension
                    vim.api.nvim_set_hl(0, hl_group, { fg = color })
                    return '%#' .. hl_group .. '#' .. icon .. '%* ' .. filename
                end,
                'diagnostics'
            },
            -- TODO: Configure lsp to see diagnostics
            lualine_x = { 
                {
                    function ()
                        local directory = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
                        return directory
                    end,
                    icon = {  ' ', align = 'right' }
                },
            },
            lualine_y = { { 'datetime', icon = { ' ', align = 'right' }, style='%H:%M:%S' } },
            lualine_z = { 'progress', 'location' },
        },
    }
}
