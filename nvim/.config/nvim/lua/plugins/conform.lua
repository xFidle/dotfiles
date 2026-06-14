return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  opts = {
    formatters = require('core.registry').get_formatters(),
    formatters_by_ft = require('core.registry').get_formatters_by_ft(),
    format_on_save = { timeout = 500, lsp_format = 'fallback' },
  },
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format({ lsp_format = 'fallback' })
      end,
      desc = 'Format current file',
    },
    {
      '<leader>ci',
      function()
        vim.cmd.checkhealth('conform')
      end,
      desc = 'Display conform info',
    },
  },
}
