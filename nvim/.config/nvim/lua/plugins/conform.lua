return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      go = { 'gofmt' },
      python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
      c = { 'clang-format' },
      cpp = { 'clang-format' },
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
