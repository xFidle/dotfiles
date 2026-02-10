return {
  'NickvanDyke/opencode.nvim',
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
