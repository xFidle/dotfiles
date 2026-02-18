return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
  },
  keys = {
    {
      '<leader>do',
      '<Cmd>DBUI<CR>',
      desc = 'Open vim-dadbod-ui',
    },
    {
      '<leader>dt',
      '<Cmd>DBUIToggle<CR>',
      desc = 'Toggle vim-dadbod-ui',
    },
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function() vim.g.db_ui_use_nerd_fonts = 1 end,
}
