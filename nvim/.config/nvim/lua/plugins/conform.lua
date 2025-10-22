return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      go = { 'gofmt' },
    },
    format_on_save = {
      timeout = 500,
      lsp_format = 'fallback',
    },
  },
  event = 'BufWritePre',
  keys = {
    {
      '<leader>cf',
      function() require('conform').format({ lsp_format = 'fallback' }) end,
      desc = 'Format current file',
    },
  },
}
