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
      '<CMD><C-U>TmuxNavigateLeft<CR>',
      desc = 'Navigate to left TMUX pane',
    },
    {
      '<c-j>',
      '<CMD><C-U>TmuxNavigateDown<CR>',
      desc = 'Navigate to bottom TMUX pane',
    },
    {
      '<c-k>',
      '<CMD><C-U>TmuxNavigateUp<CR>',
      desc = 'Navigate to upper TMUX pane',
    },
    {
      '<c-l>',
      '<CMD><C-U>TmuxNavigateRight<CR>',
      desc = 'Navigate to right TMUX pane',
    },
    {
      '<c-\\>',
      '<CMD><C-U>TmuxNavigatePrevious<CR>',
      desc = 'Navigate to previous TMUX pane',
    },
  },
}
