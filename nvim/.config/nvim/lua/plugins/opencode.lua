return {
  'NickvanDyke/opencode.nvim',
  dependencies = { 'folke/snacks.nvim', opts = { input = {}, picker = {} } },
  keys = {
    {
      '<leader>oa',
      function() require('opencode').ask(nil, { submit = true }) end,
      desc = 'Ask opencode',
    },
    {
      '<leader>oa',
      function() require('opencode').ask('@this: ', { submit = true }) end,
      mode = 'v',
      desc = 'Ask opencode about selection',
    },
    {
      '<leader>os',
      function() require('opencode').select() end,
      desc = 'Select opencode action',
    },
    {
      '<leader>ov',
      function() return require('opencode').operator('@this ') end,
      mode = 'v',
    },
  },
}
