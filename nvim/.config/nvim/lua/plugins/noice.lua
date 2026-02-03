return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    routes = {
      {
        view = 'notify',
        filter = { event = 'msg_show', kind = { 'shell_out', 'shell_err' } },
      },
      {
        filter = { event = 'notify', find = 'No information available' },
      },
    },
    presets = { lsp_doc_border = true },
    views = {
      cmdline_popup = {
        border = {
          highlight = 'FloatBorder',
        },
      },
    },
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
    { 'rcarriga/nvim-notify', opts = { stages = 'fade' } },
  },
  keys = {
    { '<leader>nd', function() require('noice').cmd('dismiss') end, desc = 'Noice dismiss' },
    { '<leader>fn', function() require('noice').cmd('fzf') end, desc = 'Find notifications' },
  },
}
