return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      c = { 'clang-format' },
      cpp = { 'clang-format' },
      go = { 'gofmt' },
      lua = { 'stylua' },
      python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
      tex = { 'latexindent' },
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
