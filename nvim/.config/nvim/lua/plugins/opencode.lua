return {
  'NickvanDyke/opencode.nvim',
  dependencies = {
    'folke/snacks.nvim',
    lazy = false,
    opts = { input = {}, picker = {} },
  },
  keys = {
    {
      '<leader>oa',
      function() require('opencode').ask(nil, { submit = true }) end,
    },
    {
      '<leader>oa',
      function() require('opencode').ask('@this: ', { submit = true }) end,
      mode = 'v',
    },
  },
}
