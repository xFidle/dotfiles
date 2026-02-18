return {
  'christoomey/vim-tmux-navigator',
  lazy = false,
  cmd = {
    'TmuxNavigateLeft',
    'TmuxNavigateDown',
    'TmuxNavigateUp',
    'TmuxNavigateRight',
    'TmuxNavigatePrevious',
    'TmuxNavigatorProcessList',
  },
  keys = {
    {
      '<c-h>',
      '<Cmd><C-U>TmuxNavigateLeft<CR>',
      desc = 'Navigate to left TMUX pane',
    },
    {
      '<c-j>',
      '<Cmd><C-U>TmuxNavigateDown<CR>',
      desc = 'Navigate to bottom TMUX pane',
    },
    {
      '<c-k>',
      '<Cmd><C-U>TmuxNavigateUp<CR>',
      desc = 'Navigate to upper TMUX pane',
    },
    {
      '<c-l>',
      '<Cmd><C-U>TmuxNavigateRight<CR>',
      desc = 'Navigate to right TMUX pane',
    },
    {
      '<c-\\>',
      '<Cmd><C-U>TmuxNavigatePrevious<CR>',
      desc = 'Navigate to previous TMUX pane',
    },
  },
}
