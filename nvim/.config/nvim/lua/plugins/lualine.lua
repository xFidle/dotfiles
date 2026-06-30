local colorscheme = require('utils.colorscheme')

local macro = {
  function()
    local reg = vim.fn.reg_recording()
    return ' recording to ' .. reg
  end,
  color = function()
    local hl = vim.api.nvim_get_hl(0, { name = 'DiagnosticError' })
    return { fg = string.format('#%06x', hl.fg) }
  end,
  cond = function()
    return vim.fn.reg_recording() ~= ''
  end,
}

local cwd = {
  function()
    return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
  end,
  icon = { ' ', align = 'right' },
}

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    theme = colorscheme.get_current(),
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
        { 'filetype', icon_only = true, colored = true, separator = '', padding = { left = 1, right = 0 } },
        { 'filename', separator = '', padding = { left = 1, right = 1 } },
        'diagnostics',
        macro,
      },
      lualine_x = {
        {
          'lsp_status',
          icon = { ' ', align = 'right' },
          symbols = { done = '' },
        },
      },
      lualine_y = {
        'encoding',
        'fileformat',
        cwd,
      },
      lualine_z = {
        'progress',
        'location',
      },
    },
  },
  config = function(_, opts)
    require('lualine').setup(opts)
    local group = vim.api.nvim_create_augroup('lualine-macro', { clear = true })
    vim.api.nvim_create_autocmd('RecordingEnter', {
      group = group,
      callback = function()
        require('lualine').refresh()
      end,
    })
    vim.api.nvim_create_autocmd('RecordingLeave', {
      group = group,
      callback = function()
        require('lualine').refresh()
      end,
    })
  end,
}
