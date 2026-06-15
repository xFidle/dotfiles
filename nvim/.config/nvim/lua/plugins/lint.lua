local reg = require('core.registry')

return {
  'mfussenegger/nvim-lint',
  opts = {
    events = { 'BufWritePost', 'BufReadPost', 'InsertLeave' },
    linters_by_ft = reg.get_linters_by_ft(),
  },
  keys = {
    {
      '<leader>ll',
      function()
        require('lint').try_lint()
      end,
      desc = 'Trigger linting for current file',
    },
  },
  config = function(_, opts)
    local lint = require('lint')
    lint.linters_by_ft = opts.linters_by_ft
    vim.api.nvim_create_autocmd(opts.events, {
      group = vim.api.nvim_create_augroup('nvim-lint', { clear = true }),
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
