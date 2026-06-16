local feat_options = {
  presets = {
    bottom_search = false,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = true,
  },
  routes = {
    {
      view = 'notify',
      filter = { event = 'msg_show', kind = { 'shell_out', 'shell_err' } },
    },
  },
  lsp = {
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
    },
    signature = { enabled = false },
    hover = { enabled = true, silent = true },
  },
}

local ui_options = {
  views = { cmdline_popup = { border = { highlight = 'FloatBorder' } } },
}

return {
  {
    'rcarriga/nvim-notify',
    opts = { stages = 'fade' },
  },
  {
    'folke/noice.nvim',
    dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' },
    event = 'VeryLazy',
    opts = vim.tbl_deep_extend('error', feat_options, ui_options),
    keys = {
      {
        '<leader>nd',
        function()
          require('noice').cmd('dismiss')
        end,
        desc = 'Noice dismiss',
      },
      {
        '<leader>nl',
        function()
          require('noice').cmd('last')
        end,
        desc = 'Display noice last message',
      },
      {
        '<leader>nh',
        function()
          require('noice').cmd('history')
        end,
        desc = 'Goto noice history',
      },
      {
        '<leader>fn',
        function()
          require('noice').cmd('fzf')
        end,
        desc = 'Find notifications',
      },
      {
        '<leader>cn',
        function()
          vim.cmd.checkhealth('noice')
        end,
        desc = 'Display noice info',
      },
    },
  },
}
