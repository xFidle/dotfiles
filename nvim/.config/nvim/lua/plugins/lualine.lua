return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      icons_enabled = true,
      globalstatus = true,
      component_separators = { left = '|', right = '|' },
      section_separators = { left = '', right = '' },
    },
    sections = {
      lualine_a = {
        { 'mode', icon = '' },
      },
      lualine_b = {
        { 'branch', icon = '' },
        'diff',
      },
      lualine_c = {
        function()
          local filename = vim.fn.expand('%:t')
          local extension = vim.fn.expand('%:e')
          local icon, color = require('nvim-web-devicons').get_icon_color(filename, extension)
          local hl_group = 'LualineFileIconColor' .. extension
          vim.api.nvim_set_hl(0, hl_group, { fg = color })
          return '%#' .. hl_group .. '#' .. icon .. '%* ' .. filename
        end,
        'diagnostics',
        {
          function()
            local reg = vim.fn.reg_recording()
            return ' recording to ' .. reg
          end,
          color = 'DiagnosticError',
          cond = function() return vim.fn.reg_recording() ~= '' end,
        },
      },
      lualine_x = {
        { 'lsp_status', icon = { ' ', align = 'right' } },
      },
      lualine_y = {
        'encoding',
        'fileformat',
        {
          function() return vim.fn.fnamemodify(vim.fn.getcwd(), ':t') end,
          icon = { ' ', align = 'right' },
        },
      },
      lualine_z = {
        'progress',
        'location',
      },
    },
  },
}
