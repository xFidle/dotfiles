local function filename()
end

local function cwd()
    return 
end

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        options = {
            theme = 'tokyonight',
            icons_enabled = true,
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
                end
            },
            -- TODO: Configure lsp to see diagnostics
            lualine_x = { 'searchcount', 'selectioncount' },
            lualine_y = { { 'datetime', style='%H:%M:%S' } },
            lualine_z = { 'progress', 'location' },
        },
    }
}
