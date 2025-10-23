return {
  {
    'nvim-mini/mini.surround',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      mappings = {
        add = 'gsa',
        delete = 'gsd',
        find = 'gsf',
        find_left = 'gsF',
        highlight = 'gsh',
        replace = 'gsr',
        update_n_lines = 'gsn',
      },
    },
  },
  {
    'nvim-mini/mini.pairs',
    event = 'InsertEnter',
    opts = {},
  },
  {
    'nvim-mini/mini.splitjoin',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },
}
